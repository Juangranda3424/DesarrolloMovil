import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  // Patrón Singleton
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('test_scan.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // 1. Materias
    await db.execute('''
    CREATE TABLE materias (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT NOT NULL,
      codigo TEXT NOT NULL
    )
    ''');

    // 2. Tabla Estudiantes
    await db.execute('''
    CREATE TABLE estudiantes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombres TEXT NOT NULL,
      apellidos TEXT NOT NULL,
      codigo TEXT NOT NULL
    )
    ''');

    // 3. Tabla Docentes
    await db.execute('''
    CREATE TABLE docentes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombres TEXT NOT NULL,
      apellidos TEXT NOT NULL,
      codigo TEXT NOT NULL
    )
    ''');

    // 4. Tabla Pruebas
    await db.execute('''
    CREATE TABLE pruebas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      materia_id INTEGER,
      nombre TEXT NOT NULL,
      fecha TEXT NOT NULL,
      introduccion TEXT,
      FOREIGN KEY (materia_id) REFERENCES materias (id) ON DELETE CASCADE
    )
    ''');

    // 5. Tabla Preguntas
    await db.execute('''
    CREATE TABLE preguntas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      prueba_id INTEGER,
      texto TEXT NOT NULL,
      tipo TEXT NOT NULL,
      opciones TEXT, 
      respuesta_correcta TEXT NOT NULL,
      valor INTEGER DEFAULT 1,
      FOREIGN KEY (prueba_id) REFERENCES pruebas (id) ON DELETE CASCADE
    )
    ''');

    // 6. Tabla Resultados
    await db.execute('''
    CREATE TABLE resultados (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      prueba_id INTEGER,
      estudiante_id INTEGER,
      nota_total REAL,
      respuesta_json TEXT,
      imagenes_paths TEXT, -- CAMBIO: Guardará un JSON Array de Strings ej: "['path1', 'path2']"
      fecha_calificacion TEXT,
      FOREIGN KEY (prueba_id) REFERENCES pruebas (id) ON DELETE CASCADE,
      FOREIGN KEY (estudiante_id) REFERENCES estudiantes (id) ON DELETE CASCADE
    )
    ''');
  }

  // ====================================================================
  //                      MÉTODOS CRUD GENÉRICOS
  // ====================================================================

  // Insertar genérico
  Future<int> _insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(table, row);
  }

  // Obtener genérico
  Future<List<Map<String, dynamic>>> _getAll(String table, {String? orderByColumn}) async {
    final db = await instance.database;

    return await db.query(
      table,
      // Si pasas una columna, ordena DESC (último a primero), si no, no ordena.
      orderBy: orderByColumn != null ? "$orderByColumn DESC" : null,
    );
  }

  // Actualizar genérico
  Future<int> _update(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  // Eliminar genérico
  Future<int> _delete(String table, int id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // ====================================================================
  //                      1. MATERIAS
  // ====================================================================

  Future<int> createMateria(Map<String, dynamic> row) async => await _insert('materias', row);
  Future<List<Map<String, dynamic>>> getAllMaterias() async => await _getAll('materias', orderByColumn: 'id');
  Future<int> updateMateria(Map<String, dynamic> row) async => await _update('materias', row);
  Future<int> deleteMateria(int id) async => await _delete('materias', id);

  // ====================================================================
  //                      2. ESTUDIANTES
  // ====================================================================

  Future<int> createEstudiante(Map<String, dynamic> row) async => await _insert('estudiantes', row);
  Future<List<Map<String, dynamic>>> getAllEstudiantes() async => await _getAll('estudiantes');
  Future<int> updateEstudiante(Map<String, dynamic> row) async => await _update('estudiantes', row);
  Future<int> deleteEstudiante(int id) async => await _delete('estudiantes', id);

  // ====================================================================
  //                      3. DOCENTES
  // ====================================================================

  Future<int> createDocente(Map<String, dynamic> row) async => await _insert('docentes', row);
  Future<List<Map<String, dynamic>>> getAllDocentes() async => await _getAll('docentes');
  Future<int> updateDocente(Map<String, dynamic> row) async => await _update('docentes', row);
  Future<int> deleteDocente(int id) async => await _delete('docentes', id);

  // ====================================================================
  //                      4. PRUEBAS
  // ====================================================================

  Future<int> createPrueba(Map<String, dynamic> row) async => await _insert('pruebas', row);
  Future<int> updatePrueba(Map<String, dynamic> row) async => await _update('pruebas', row);
  Future<int> deletePrueba(int id) async => await _delete('pruebas', id);
  Future<List<Map<String, dynamic>>> getAllPruebas() async => await _getAll('pruebas', orderByColumn: 'id');


  // CONSULTA ESPECÍFICA: Obtener pruebas por ID de Materia
  // Útil para mostrar: "Estas son las pruebas de Matemáticas"
  Future<List<Map<String, dynamic>>> getPruebasByMateriaId(int materiaId) async {
    final db = await instance.database;
    return await db.query(
      'pruebas',
      where: 'materia_id = ?',
      whereArgs: [materiaId],
      orderBy: 'fecha DESC', // Ordenadas por fecha descendente
    );
  }

  // ====================================================================
  //                      5. PREGUNTAS
  // ====================================================================

  Future<int> createPregunta(Map<String, dynamic> row) async => await _insert('preguntas', row);
  // Elimina todas las preguntas de una prueba (útil antes de re-importar)
  Future<int> deletePreguntasByPruebaId(int pruebaId) async {
    final db = await instance.database;
    return await db.delete('preguntas', where: 'prueba_id = ?', whereArgs: [pruebaId]);
  }

  // Obtener preguntas de una prueba específica
  Future<List<Map<String, dynamic>>> getPreguntasByPruebaId(int pruebaId) async {
    final db = await instance.database;
    return await db.query('preguntas', where: 'prueba_id = ?', whereArgs: [pruebaId]);
  }

  // ====================================================================
  //                      6. RESULTADOS
  // ====================================================================

  Future<int> createResultado(Map<String, dynamic> row) async => await _insert('resultados', row);

  // CONSULTA ESPECÍFICA: Obtener resultados por ID de Estudiante
  // Esto retorna todas las pruebas que el estudiante ha rendido.
  // Hago un JOIN para que traiga también el NOMBRE DE LA PRUEBA y el NOMBRE DE LA MATERIA.
  Future<List<Map<String, dynamic>>> getResultadosByEstudianteId(int estudianteId) async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT 
        r.id as resultado_id,
        r.nota_total,
        r.fecha_calificacion,
        r.imagenes_paths, -- Ahora traemos el JSON de paths
        p.nombre as prueba_nombre,
        m.nombre as materia_nombre
      FROM resultados r
      INNER JOIN pruebas p ON r.prueba_id = p.id
      INNER JOIN materias m ON p.materia_id = m.id
      WHERE r.estudiante_id = ?
      ORDER BY r.fecha_calificacion DESC
    ''', [estudianteId]);
  }

  // CONSULTA ESPECÍFICA: Obtener todos los resultados de una prueba específica
  // (Para exportar a Excel, por ejemplo)
  Future<List<Map<String, dynamic>>> getResultadosByPruebaId(int pruebaId) async {
    final db = await instance.database;

    return await db.rawQuery('''
      SELECT 
        r.nota_total,
        e.nombres,
        e.apellidos,
        e.codigo
      FROM resultados r
      INNER JOIN estudiantes e ON r.estudiante_id = e.id
      WHERE r.prueba_id = ?
    ''', [pruebaId]);
  }

  // Actualizar una pregunta individual
  Future<int> updatePregunta(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update(
        'preguntas',
        row,
        where: 'id = ?',
        whereArgs: [row['id']]
    );
  }

  // Eliminar una pregunta individual
  Future<int> deletePregunta(int id) async {
    final db = await instance.database;
    return await db.delete('preguntas', where: 'id = ?', whereArgs: [id]);
  }


}