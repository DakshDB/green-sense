import 'package:flutter/material.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/layout/responsive_container.dart';
import 'package:green_sense/widgets/forms/custom_text_field.dart';
import 'package:green_sense/widgets/forms/custom_dropdown.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  String _subject = 'General';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Contact Us',
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Hero Section
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor.withOpacity(0.1),
                      AppColors.accentColor.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.mail_outline,
                          size: 48,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Get in Touch',
                            style: Responsive.isMobile(context)
                                ? AppStyles.headline2
                                : AppStyles.headline1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Have questions, feedback, or want to collaborate? We\'d love to hear from you!',
                      style: AppStyles.bodyText.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Two Column Layout on Desktop
              Responsive.isDesktop(context)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildContactForm(),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _buildContactInfo(),
                              const SizedBox(height: 24),
                              _buildFAQ(),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildContactForm(),
                        const SizedBox(height: 32),
                        _buildContactInfo(),
                        const SizedBox(height: 32),
                        _buildFAQ(),
                      ],
                    ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send us a Message',
              style: AppStyles.headline2,
            ),
            const SizedBox(height: 24),

            CustomTextField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'Enter your full name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'your.email@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            CustomDropdown(
              value: _subject,
              label: 'Subject',
              items: ['General', 'Feedback', 'Partnership', 'Bug Report', 'Other'],
              onChanged: (value) {
                setState(() {
                  _subject = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell us what\'s on your mind...',
              maxLines: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                if (value.length < 10) {
                  return 'Message must be at least 10 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _handleSubmit,
                icon: _isSubmitting
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(_isSubmitting ? 'Sending...' : 'Send Message'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBackgroundColor:
                      AppColors.textSecondary.withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 20),

          _buildContactItem(
            icon: Icons.email,
            title: 'Email',
            content: 'contact@greensense.earth',
            onTap: () async {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: 'contact@greensense.earth',
                query: 'subject=Green Sense Inquiry',
              );
              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
              }
            },
          ),

          const SizedBox(height: 16),

          _buildContactItem(
            icon: Icons.public,
            title: 'Website',
            content: 'www.greensense.earth',
            onTap: () async {
              final Uri url = Uri.parse('https://www.greensense.earth');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
          ),

          const SizedBox(height: 24),

          Text(
            'Follow Us',
            style: AppStyles.bodyText.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              _buildSocialButton(
                icon: Icons.facebook,
                url: 'https://facebook.com/greensense',
              ),
              const SizedBox(width: 12),
              _buildSocialButton(
                icon: Icons.twitter,
                url: 'https://twitter.com/greensense',
              ),
              const SizedBox(width: 12),
              _buildSocialButton(
                icon: Icons.link,
                url: 'https://instagram.com/greensense',
              ),
              const SizedBox(width: 12),
              _buildSocialButton(
                icon: Icons.link,
                url: 'https://linkedin.com/company/greensense',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    content,
                    style: AppStyles.bodyText.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textSecondary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
  }) {
    return InkWell(
      onTap: () async {
        final Uri socialUrl = Uri.parse(url);
        if (await canLaunchUrl(socialUrl)) {
          await launchUrl(socialUrl, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildFAQ() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: AppStyles.headline3,
          ),
          const SizedBox(height: 20),

          _buildFAQItem(
            question: 'How accurate is the carbon calculator?',
            answer:
                'Our calculator uses industry-standard emission factors and provides estimates within 10-15% accuracy based on average data.',
          ),

          _buildFAQItem(
            question: 'Is my data stored?',
            answer:
                'All calculations are performed locally in your browser. We don\'t store any personal data unless you create an account.',
          ),

          _buildFAQItem(
            question: 'Can I suggest new features?',
            answer:
                'Absolutely! We love hearing from our community. Use the form above to share your ideas.',
          ),

          _buildFAQItem(
            question: 'How can I contribute?',
            answer:
                'We welcome partnerships, content contributions, and volunteers. Contact us to discuss collaboration opportunities.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.help_outline,
                color: AppColors.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: AppStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              answer,
              style: AppStyles.bodyText.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Thank you! Your message has been sent. We\'ll get back to you soon.',
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.primaryColor,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );

        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        setState(() {
          _subject = 'General';
        });
      }
    }
  }
}
