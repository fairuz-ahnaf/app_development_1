import 'package:material_ui/material_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
  url: 'https://sjfntqehfmmuzvqftwxz.supabase.co/',
  publishableKey: 'sb_publishable_I1ewLDkS158cSXPmG2kb6g_ca9STWkd',
  );
  runApp(const MaterialApp(home: NotesPage()));
}

final db = Supabase.instance.client;

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List notes = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  // READ
  Future<void> load() async {
    final data = await db.from('notes').select().order('id', ascending: true);
    setState(() => notes = data);
  }

  // CREATE & UPDATE (n == null berarti tambah, selain itu edit)
  Future<void> form([Map? n]) async {
    final t = TextEditingController(text: n?['title']);
    final c = TextEditingController(text: n?['content']);
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(n == null ? 'Tambah' : 'Edit'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: t, decoration: const InputDecoration(labelText: 'Title')),
          TextField(controller: c, decoration: const InputDecoration(labelText: 'Content')),
        ]),
        actions: [
          TextButton(
            child: const Text('Simpan'),
            onPressed: () async {
              final row = {'title': t.text, 'content': c.text};
              if (n == null) {
                await db.from('notes').insert(row);
              } else {
                await db.from('notes').update(row).eq('id', n['id']);
              }
              if (mounted) Navigator.pop(context);
              load();
            },
          ),
        ],
      ),
    );
  }

  // DELETE
  Future<void> hapus(int id) async {
    await db.from('notes').delete().eq('id', id);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => form(),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Content')),
            DataColumn(label: Text('Aksi')),
          ],
          rows: notes.map((n) => DataRow(cells: [
            DataCell(Text('${n['id']}')),
            DataCell(Text(n['title'] ?? '')),
            DataCell(Text(n['content'] ?? '')),
            DataCell(Row(children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: () => form(n)),
              IconButton(icon: const Icon(Icons.delete), onPressed: () => hapus(n['id'])),
            ])),
          ])).toList(),
        ),
      ),
    );
  }
}