import 'package:flutter/material.dart';
import 'services/api_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController =
      TextEditingController();

  final ScrollController _scrollController =
      ScrollController();

  final List<Map<String, String>> _messages = [];

  String? _sessionId;

  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();

    if (message.isEmpty || _isLoading) {
      return;
    }

    setState(() {
      _messages.add({
        'sender': 'user',
        'message': message,
      });

      _messageController.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final result = await ApiService.sendMessage(
        userId: 'test-user-001',
        message: message,
        sessionId: _sessionId,
      );

      if (!mounted) return;

      setState(() {
        _sessionId = result.sessionId;

        _messages.add({
          'sender': 'ai',
          'message': result.message,
        });
      });

      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _messages.add({
          'sender': 'ai',
          'message':
              'Connection error:\n\n$e',
        });
      });

      _scrollToBottom();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF6F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B7A6E),
        foregroundColor: Colors.white,
        title: const Text(
          'Namma Health',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildWelcome()
                : _buildMessages(),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Namma Health is thinking...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.health_and_safety_rounded,
                size: 64,
                color: Color(0xFF1B7A6E),
              ),
              SizedBox(height: 20),
              Text(
                'Hello! 👋',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF145E55),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'I am Namma Health.\n\n'
                'Ask me a health question and I will '
                'provide simple health information.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  height: 1.4,
                  color: Color(0xFF1C2B28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final item = _messages[index];

        final isUser =
            item['sender'] == 'user';

        return Align(
          alignment: isUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width *
                      0.82,
            ),
            margin:
                const EdgeInsets.only(bottom: 14),
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: isUser
                  ? const Color(0xFFD5EEE8)
                  : Colors.white,
              borderRadius:
                  BorderRadius.only(
                topLeft:
                    const Radius.circular(18),
                topRight:
                    const Radius.circular(18),
                bottomLeft:
                    Radius.circular(
                  isUser ? 18 : 4,
                ),
                bottomRight:
                    Radius.circular(
                  isUser ? 4 : 18,
                ),
              ),
            ),
            child: Text(
              item['message'] ?? '',
              style: const TextStyle(
                fontSize: 18,
                height: 1.4,
                color: Color(0xFF1C2B28),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputArea() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          12,
          10,
          12,
          12,
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller:
                    _messageController,
                enabled: !_isLoading,
                minLines: 1,
                maxLines: 4,
                textInputAction:
                    TextInputAction.send,
                onSubmitted:
                    (_) => _sendMessage(),
                decoration:
                    InputDecoration(
                  hintText:
                      'Type your health question...',
                  hintStyle:
                      const TextStyle(
                    fontSize: 17,
                  ),
                  filled: true,
                  fillColor:
                      const Color(0xFFEEF6F1),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20),
                    borderSide:
                        BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
                style:
                    const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color:
                  const Color(0xFF1B7A6E),
              borderRadius:
                  BorderRadius.circular(18),
              child: InkWell(
                onTap: _isLoading
                    ? null
                    : _sendMessage,
                borderRadius:
                    BorderRadius.circular(18),
                child: const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}