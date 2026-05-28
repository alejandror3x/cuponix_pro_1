import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/cupon_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage('Hola, quiero usar el cupón de 20%.', true),
    const _ChatMessage('Perfecto. Muestra el código QR cuando llegues.', false),
    const _ChatMessage('Gracias, estaré en 20 minutos.', true),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _messages.add(_ChatMessage(text, true)));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
                child: Row(
                  children: [
                    BackTriangle(onTap: () => context.go('/mensajes')),
                    const SizedBox(width: 12),
                    const CircleAvatar(radius: 22, backgroundColor: Color(0xFFD4322B), child: Text('R', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Roger's Smash", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600)),
                          Text('@rogersec', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/fondo-negro.png'), fit: BoxFit.cover)),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                  itemCount: _messages.length + 1,
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 18),
                        child: Center(child: Text('Hoy', style: TextStyle(color: Colors.white70, fontSize: 13))),
                      );
                    }
                    final msg = _messages[index - 1];
                    return _Bubble(text: msg.text, sent: msg.sent);
                  },
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)),
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: AppColors.ink),
                          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 10)),
                          onSubmitted: (_) => _send(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _send,
                      child: Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: AppColors.neonRed, borderRadius: BorderRadius.circular(999)),
                        alignment: Alignment.center,
                        child: const Text('ENVIAR', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool sent;
  const _ChatMessage(this.text, this.sent);
}

class _Bubble extends StatelessWidget {
  final String text;
  final bool sent;

  const _Bubble({required this.text, required this.sent});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: sent ? AppColors.neonRed : const Color(0xE0555555), borderRadius: BorderRadius.circular(18)),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.25)),
      ),
    );
  }
}
