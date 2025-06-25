import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 768;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isWideScreen),
            const SizedBox(height: 32),
            if (isWideScreen)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildContactForm(context)),
                  const SizedBox(width: 32),
                  Expanded(child: _buildContactInfo(context)),
                ],
              )
            else
              Column(
                children: [
                  _buildContactForm(context),
                  const SizedBox(height: 32),
                  _buildContactInfo(context),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isWideScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get In Touch',
          style: GoogleFonts.poppins(
            fontSize: isWideScreen ? 36 : 28,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
        
        const SizedBox(height: 8),
        
        Text(
          'Have a project in mind? Let\'s discuss how we can work together',
          style: GoogleFonts.poppins(
            fontSize: isWideScreen ? 18 : 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.2),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send a Message',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 24),
              
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email *',
                  hintText: 'Enter your email address',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject *',
                  hintText: 'What is this about?',
                  prefixIcon: const Icon(Icons.subject_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Subject is required';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message *',
                  hintText: 'Tell me about your project or inquiry...',
                  prefixIcon: const Icon(Icons.message_outlined),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Message is required';
                  }
                  if (value.trim().length < 10) {
                    return 'Message should be at least 10 characters';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2),
              
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _submitForm,
                  icon: _isSubmitting 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                  label: Text(_isSubmitting ? 'Sending...' : 'Send Message'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms).scale(begin: const Offset(0.9, 0.9)),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2);
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      children: [
        _buildContactCard(
          context,
          'Email',
          'dilawarhussain6465@gmail.com',
          Icons.email_outlined,
          () => _launchUrl('mailto:dilawarhussain6465@gmail.com'),
        ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.2),
        
        const SizedBox(height: 16),
        
        _buildContactCard(
          context,
          'Phone',
          '+92 348 4947995',
          Icons.phone_outlined,
          () => _launchUrl('tel:+923484947995'),
        ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),
        
        const SizedBox(height: 16),
        
        _buildContactCard(
          context,
          'Location',
          'Pakistan',
          Icons.location_on_outlined,
          null,
        ).animate().fadeIn(delay: 1100.ms).slideY(begin: 0.2),
        
        const SizedBox(height: 24),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Quick Response',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'I typically respond within 24 hours during business days',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Available 9 AM - 6 PM (PKT)',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.2),
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate form submission
      await Future.delayed(const Duration(seconds: 2));
      
      // Create email link with form data
      final emailBody = '''
Name: ${_nameController.text}
Email: ${_emailController.text}
Subject: ${_subjectController.text}

Message:
${_messageController.text}
      ''';
      
      final emailUrl = Uri.encodeComponent(emailBody);
      await _launchUrl('mailto:dilawarhussain6465@gmail.com?subject=${Uri.encodeComponent(_subjectController.text)}&body=$emailUrl');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Message sent successfully!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
        
        // Clear form
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to send message. Please try again.'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}