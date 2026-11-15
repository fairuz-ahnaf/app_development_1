import 'package:flutter/material.dart';

import 'data.dart';
import 'menuscreen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          _buildHero(context),
          const SizedBox(height: 16),
          _buildStats(context),
          SectionHeader(
            title: 'Proyek Unggulan',
            actionLabel: 'Lihat semua',
            onAction: () => onNavigate(1),
          ),
          _buildFeatured(),
          const SectionHeader(title: 'Keahlian'),
          _buildSkills(),
          const SectionHeader(title: 'Tentang Singkat'),
          _buildAboutCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // Container + gradient: bagian pembuka (hero)
  Widget _buildHero(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final soft = scheme.onPrimary.withValues(alpha: 0.85);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.onPrimary,
                ),
                child: const ProfileAvatar(radius: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Halo, saya',
                        style: text.bodyLarge?.copyWith(color: soft)),
                    Text(
                      Identity.name,
                      style: text.titleLarge?.copyWith(
                        color: scheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            Identity.tagline,
            style: text.bodyLarge?.copyWith(color: scheme.onPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            '${Identity.prodi} · Angkatan ${Identity.angkatan}',
            style: text.bodyMedium?.copyWith(color: soft),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              FilledButton(
                onPressed: () => onNavigate(1),
                style: FilledButton.styleFrom(
                  backgroundColor: scheme.onPrimary,
                  foregroundColor: scheme.primary,
                ),
                child: const Text('Lihat Proyek'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => onNavigate(2),
                style: OutlinedButton.styleFrom(
                  foregroundColor: scheme.onPrimary,
                  side: BorderSide(color: scheme.onPrimary),
                ),
                child: const Text('Profil Saya'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Row + Expanded: tiga kartu statistik sama lebar
  Widget _buildStats(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    Widget item(IconData icon, String value, String label) => Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                children: [
                  Icon(icon, color: scheme.primary),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: text.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(label, style: text.bodySmall),
                ],
              ),
            ),
          ),
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          item(Icons.school, '${Identity.semester}', 'Semester'),
          item(Icons.folder_copy, '${projects.length}', 'Proyek'),
          item(Icons.bolt, '${skills.length}', 'Keahlian'),
        ],
      ),
    );
  }

  // ListView horizontal berisi kartu proyek
  Widget _buildFeatured() {
    final featured = projects.take(3).toList();
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: featured.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, i) => SizedBox(
          width: 220,
          child: ProjectCard(project: featured[i]),
        ),
      ),
    );
  }

  // Wrap + Chip
  Widget _buildSkills() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final s in skills)
            Chip(avatar: Icon(s.icon, size: 18), label: Text(s.name)),
        ],
      ),
    );
  }

  Widget _buildAboutCard() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(Identity.about),
      ),
    );
  }
}