import 'package:flutter/material.dart';

// ============================================================
// data.dart : data portofolio + widget kecil yang dipakai bersama
// Ganti isi bagian yang bertanda "CONTOH" dengan datamu sendiri.
// ============================================================

class Identity {
  static const name = 'Muhammad Fairuz Ahnaf';
  static const nrp = '5026241169';
  static const prodi = 'S1 Sistem Informasi';
  static const angkatan = '2024';
  static const semester = 5;
  static const course = 'Teknologi Berkembang';
  static const kelas = 'B';
  static const role = 'Mahasiswa Sistem Informasi';
  static const tagline = 'Belajar membangun aplikasi mobile dengan Flutter.';
  static const about =
      'Mahasiswa S1 Sistem Informasi angkatan 2024 yang sedang menempuh '
      'semester 5. Tertarik pada pengembangan aplikasi mobile dengan Flutter, '
      'perancangan antarmuka, dan pengelolaan data. Aplikasi ini dibuat '
      'sebagai tugas individu mata kuliah Teknologi Berkembang kelas B.';

  // CONTOH: ganti dengan kontak aslimu
  static const email = 'email@contoh.com';
  static const github = 'github.com/username';
  static const linkedin = 'linkedin.com/in/username';
  static const instagram = '@username';
}

class Assets {
  static const profile = 'assets/images/profile.jpg';
  static const projectKopi = 'assets/images/project_kopi.png';
  static const projectPortfolio = 'assets/images/project_portfolio.png';
  static const projectInventory = 'assets/images/project_inventory.png';
  static const projectDashboard = 'assets/images/project_dashboard.png';
}

class Project {
  final String title;
  final String subtitle;
  final String description;
  final String category; // Mobile / Web / Data
  final String image;
  final IconData icon;
  final List<String> tech;

  const Project({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.image,
    required this.icon,
    required this.tech,
  });
}

// CONTOH: ganti dengan proyekmu
const projects = <Project>[
  Project(
    title: 'Kopi Kita',
    subtitle: 'Aplikasi katalog dan pemesanan kopi',
    description:
        'Aplikasi mobile sederhana untuk menampilkan menu kopi, detail '
        'produk, dan keranjang pesanan. Dibuat untuk latihan layout dan '
        'navigasi di Flutter.',
    category: 'Mobile',
    image: Assets.projectKopi,
    icon: Icons.coffee,
    tech: ['Flutter', 'Dart', 'Material 3'],
  ),
  Project(
    title: 'Portofolio Mobile',
    subtitle: 'Aplikasi portofolio pribadi',
    description:
        'Aplikasi yang sedang kamu lihat ini. Memiliki navigasi bawah, '
        'filter proyek, panel yang bisa ditarik, dan mode gelap.',
    category: 'Mobile',
    image: Assets.projectPortfolio,
    icon: Icons.person_pin,
    tech: ['Flutter', 'Dart', 'Dark Mode'],
  ),
  Project(
    title: 'SI Inventory',
    subtitle: 'Sistem pencatatan stok barang',
    description:
        'Rancangan sistem informasi untuk mencatat barang masuk dan keluar '
        'beserta laporan stok, dengan basis data relasional.',
    category: 'Web',
    image: Assets.projectInventory,
    icon: Icons.inventory_2,
    tech: ['PostgreSQL', 'SQL', 'Web'],
  ),
  Project(
    title: 'Dashboard Penjualan',
    subtitle: 'Analisis dan visualisasi data penjualan',
    description:
        'Dashboard untuk melihat tren penjualan per periode dan per '
        'kategori produk agar keputusan bisnis lebih mudah diambil.',
    category: 'Data',
    image: Assets.projectDashboard,
    icon: Icons.insights,
    tech: ['SQL', 'Spreadsheet', 'Visualisasi'],
  ),
];

class Skill {
  final String name;
  final double level; // 0.0 - 1.0
  final IconData icon;
  const Skill(this.name, this.level, this.icon);
}

// CONTOH: sesuaikan level dengan kemampuanmu
const skills = <Skill>[
  Skill('Flutter & Dart', 0.55, Icons.phone_android),
  Skill('UI Design (Figma)', 0.50, Icons.palette),
  Skill('SQL & Database', 0.65, Icons.storage),
  Skill('Analisis Sistem', 0.60, Icons.account_tree),
  Skill('Git & GitHub', 0.50, Icons.merge_type),
];

// ------------------------------------------------------------
// Widget bersama
// ------------------------------------------------------------

/// Image.asset dengan placeholder otomatis jika file belum ada,
/// supaya aplikasi tidak error walau gambar belum dimasukkan.
Widget safeAsset(
  String path, {
  BoxFit fit = BoxFit.cover,
  IconData fallback = Icons.image_outlined,
}) {
  return Image.asset(
    path,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      final scheme = Theme.of(context).colorScheme;
      return Container(
        color: scheme.surfaceContainerHighest,
        alignment: Alignment.center,
        child: Icon(fallback, size: 36, color: scheme.onSurfaceVariant),
      );
    },
  );
}

class ProfileAvatar extends StatelessWidget {
  final double radius;
  const ProfileAvatar({super.key, this.radius = 48});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: safeAsset(Assets.profile, fallback: Icons.person),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: text.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (actionLabel != null)
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}