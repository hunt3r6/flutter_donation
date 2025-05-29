// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/donate/donate_cubit.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_donation/core/widget/action_button.dart';
import 'package:flutter_donation/core/widget/custom_app_bar.dart';
import 'package:flutter_donation/core/widget/form_text_field.dart';

class DonatePage extends StatefulWidget {
  final String slugCampaign;
  const DonatePage({super.key, required this.slugCampaign});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener<DonateCubit, DonateState>(
        listener: (context, state) {
          if (state is DonateSuccess) {
            context.go('/dashboard/my_donations');
          } else if (state is DonateError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                const Text(
                  'Masukkan Nominal Donasi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                FormTextField(
                  controller: _amountController,
                  hintText: 'Nominal Donasi',
                  prefixIcon: Icons.monetization_on,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon Masukkan Nominal Donasi';
                    }
                    final amount = int.tryParse(
                      value.replaceAll('.', '').replaceAll(',', ''),
                    );
                    if (amount == null) {
                      return 'Nominal tidak valid';
                    }

                    if (amount < 10000) {
                      return 'Minimal donasi Rp 10.000';
                    }

                    return null;
                  },
                ),
                FormTextField(
                  controller: _messageController,
                  hintText: 'Tulis Do\'a / Ucapan',
                  prefixIcon: Icons.handshake,
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                ActionButton(
                  label: 'Lanjut Pembayaran',
                  onPressed: donatePayment,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void donatePayment() {
    if (_formKey.currentState!.validate()) {
      final amount = _amountController.text;
      final message = _messageController.text;
      context.read<DonateCubit>().donate(amount, message, widget.slugCampaign);
    }
  }
}
