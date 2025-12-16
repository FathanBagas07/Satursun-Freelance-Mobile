import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satursun_app/core/services/job_service.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';

const Color _saturSunGrey = Color(0xFFBDBDBD);

class TaskSubmissionScreen extends StatefulWidget {
  final Map<String, dynamic> taskData;
  const TaskSubmissionScreen({super.key, required this.taskData});

  @override
  State<TaskSubmissionScreen> createState() => _TaskSubmissionScreenState();
}

class _TaskSubmissionScreenState extends State<TaskSubmissionScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    try {
      final taskId = widget.taskData['id'];
      if (taskId == null) throw Exception("Task ID not found");

      await jobService.submitTask(taskId, _notesController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Tugas berhasil dikumpulkan!")));
      context.go('/freelancer/tasks'); 

    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.onPrimary, Theme.of(context).colorScheme.secondary],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          _buildBody(context),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handleSubmit,
          style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), elevation: 5),
          child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Text('Kumpul', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface, fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 160),
      child: Column(
        children: [
          _buildAppBar(context),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pengumpulan Tugas', style: textTheme.headlineMedium!.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface)),
                const SizedBox(height: 10),
                Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20)), child: Text('Progres', style: textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(child: _buildUploadCard(context)),
          const SizedBox(height: 20),
          _buildNotesCard(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Row(children: [IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.surface), onPressed: () => context.pop()), Text('SaturSun Freelance', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.surface))]),
      ),
    );
  }

  Widget _buildUploadCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double cardWidth = MediaQuery.of(context).size.width - 40;
    return Container(
      width: cardWidth, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Row(children: [Icon(Icons.assignment_outlined, color: Theme.of(context).colorScheme.onSurface, size: 24), const SizedBox(width: 8), Expanded(child: Text(widget.taskData['title'] ?? 'Tugas', overflow: TextOverflow.ellipsis, maxLines: 1, style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)))])), const SizedBox(width: 8), GestureDetector(onTap: () {}, child: Text('Edit', style: textTheme.bodyMedium!.copyWith(fontSize: 14, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)))]),
        const SizedBox(height: 20),
        Container(width: double.infinity, height: 200, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300, width: 1.5), borderRadius: BorderRadius.circular(15)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.cloud_upload_outlined, color: Theme.of(context).colorScheme.primary, size: 50), const SizedBox(height: 15), Text('Upload karya (max 20MB)', style: textTheme.bodyMedium!.copyWith(color: Colors.grey[600], fontSize: 14)), const SizedBox(height: 20), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text('Pilih File', style: textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold)))])),
        const SizedBox(height: 20), const Divider(), const SizedBox(height: 10),
        _buildUploadedFileItem(context, 'poster_final_v2.jpg', '15MB'),
      ]),
    );
  }

  Widget _buildUploadedFileItem(BuildContext context, String fileName, String fileSize) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(padding: const EdgeInsets.only(bottom: 12.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text(fileName, overflow: TextOverflow.ellipsis, style: textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.w500))), Row(children: [Text(fileSize, style: textTheme.bodySmall!.copyWith(fontSize: 13, color: Colors.grey)), const SizedBox(width: 10), const Icon(Icons.delete_outline, color: _saturSunGrey, size: 20)])]));
  }

  Widget _buildNotesCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Catatan Tambahan (opsional)', style: textTheme.bodyLarge!.copyWith(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 10), TextField(controller: _notesController, maxLines: 3, decoration: InputDecoration(hintText: 'contoh : Halo, berikut hasil desainnya.', hintStyle: textTheme.bodyMedium!.copyWith(color: Colors.grey[400], fontSize: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)), filled: true, fillColor: Colors.grey.shade50))]));
  }
}