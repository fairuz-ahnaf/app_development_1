import 'package:flutter/material.dart';

import 'data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Stack: konten profil di bawah, panel "Tentang Saya" di atasnya
    return Stack(
      children: [
        Scrollbar(
          child: ListView(
            children: [
              _buildHeader(context),
              const SizedBox(height: 64),
              _buildIdentity(context),
              const SizedBox(height: 16),
              _buildInfoCard(),
              const SectionHeader(title: 'Level Keahlian'),
              _buildSkillBars(context),
              const SectionHeader(title: 'Kontak'),
              _buildContacts(context),
              // ruang kosong agar tidak tertutup panel
              const SizedBox(height: 120),
            ],
          ),
        ),
        _buildAboutSheet(context),
      ],
    );
  }

  // Stack: banner + foto profil menumpuk
  Widget _buildHeader(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [scheme.primary, scheme.tertiary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          bottom: -52,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: scheme.surface, width: 4),
            ),
            child: const ProfileAvatar(radius: 52),
          ),
        ),
      ],
    );
  }

  Widget _buildIdentity(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          Identity.name,
          textAlign: TextAlign.center,
          style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text('NRP ${Identity.nrp}', style: text.bodyLarge),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          children: [
            Chip(label: Text(Identity.prodi)),
            Chip(label: Text('Semester ${Identity.semester}')),
          ],
        ),
      ],
    );
  }

  // Card + ListTile + Divider
  Widget _buildInfoCard() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.badge),
            title: Text('NRP'),
            subtitle: Text(Identity.nrp),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Program Studi'),
            subtitle: Text('${Identity.prodi} · Angkatan ${Identity.angkatan}'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Semester'),
            subtitle: Text('Semester ${Identity.semester}'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Mata Kuliah'),
            subtitle: Text('${Identity.course} · Kelas ${Identity.kelas}'),
          ),
        ],
      ),
    );
  }

  // LinearProgressIndicator: level keahlian
  Widget _buildSkillBars(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final s in skills)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(s.icon, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(s.name, style: text.bodyLarge)),
                      Text('${(s.level * 100).round()}%'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: s.level,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContacts(BuildContext context) {
    Widget item(IconData icon, String label, String value) => Column(
          children: [
            IconButton.filledTonal(
              icon: Icon(icon),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$label: $value')),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        item(Icons.email, 'Email', Identity.email),
        item(Icons.code, 'GitHub', Identity.github),
        item(Icons.business_center, 'LinkedIn', Identity.linkedin),
        item(Icons.camera_alt, 'Instagram', Identity.instagram),
      ],
    );
  }

  // DraggableScrollableSheet: panel "Tentang Saya" yang bisa ditarik
  Widget _buildAboutSheet(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: const [
              BoxShadow(blurRadius: 10, color: Colors.black26),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: const [
              Center(
                child: SizedBox(width: 40, child: Divider(thickness: 4)),
              ),
              Text(
                'Tentang Saya',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(Identity.about),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.flag),
                title: Text('Fokus Semester Ini'),
                subtitle: Text('Menguasai layout, navigasi, dan state di Flutter'),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Motto'),
                subtitle: Text('Belajar sedikit demi sedikit, tapi konsisten.'),
              ),
            ],
          ),
        );
      },
    );
  }
}