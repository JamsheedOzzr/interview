import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          Center(
            child: CircleAvatar(
              radius: 46,
              backgroundColor: Colors.indigo.shade100,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              user.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              '@${user.username}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),

          _sectionTitle(context, 'Personal Information'),
          _detailCard(Icons.badge_outlined, 'User ID', '${user.id}'),
          _detailCard(Icons.person_outline, 'Username', user.username),
          _detailCard(Icons.email_outlined, 'Email', user.email),
          _detailCard(Icons.phone_outlined, 'Phone', user.phone),

          _sectionTitle(context, 'Website'),
          Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.language, color: Colors.indigo),
              title: const Text('Website', style: TextStyle(fontSize: 12, color: Colors.grey)),
              subtitle: Text(user.website, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              trailing: const Icon(Icons.open_in_new_rounded, size: 18),
              onTap: () => _openWebsite(context, user.website),
            ),
          ),

          _sectionTitle(context, 'Address'),
          _detailCard(Icons.location_city_outlined, 'Street', user.address.street),
          _detailCard(Icons.home_outlined, 'Suite', user.address.suite),
          _detailCard(Icons.location_on_outlined, 'City', user.address.city),
          _detailCard(Icons.markunread_mailbox_outlined, 'ZIP Code', user.address.zipcode),
          _detailCard(Icons.map_outlined, 'Coordinates', 'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}'),

          _sectionTitle(context, 'Company'),
          _detailCard(Icons.business_outlined, 'Company Name', user.company.name),
          _detailCard(Icons.chat_bubble_outline_rounded, 'Catch Phrase', user.company.catchPhrase),
          _detailCard(Icons.work_outline_rounded, 'Business', user.company.bs),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _detailCard(IconData icon, String title, String value) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(
          value.isEmpty ? 'N/A' : value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }

  Future<void> _openWebsite(BuildContext context, String website) async {
    final normalized = website.trim();
    if (normalized.isEmpty) {
      _showError(context);
      return;
    }

    final uri = Uri.tryParse(
      normalized.startsWith('http://') || normalized.startsWith('https://')
          ? normalized
          : 'https://$normalized',
    );

    if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https') || uri.host.isEmpty) {
      _showError(context);
      return;
    }

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && context.mounted) {
        _showError(context);
      }
    } catch (_) {
      if (context.mounted) {
        _showError(context);
      }
    }
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open website link.')),
    );
  }
}
