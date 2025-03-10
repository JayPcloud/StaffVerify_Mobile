import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:staff_verify/data/services/qr_code_service.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/device.dart';
import '../../../utils/helpers/helper_func.dart';
import '../../staff_verification/models/staff_model.dart';

class VRegConfirmationController extends GetxController {


  final Staff staff;
  VRegConfirmationController({required this.staff});

  @override
  void onInit() {
    Future.delayed(Duration(milliseconds: 100), ()=> VHelperFunc.snackBarNotifier(
        msg: 'Registration Successful',
      txtColor: VColors.whiteText,
      position: SnackPosition.TOP
    ));
    super.onInit();
  }

  RxBool generatingPdf = false.obs;

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    // Generate QR code image
    final qrImage = await VQRCodeGenerator(qrData: staff.qrcodeData!).toUInt8List();
    final netImage = await networkImage('https://www.nfet.net/nfet.jpg');

    PdfColor darkColor = PdfColor.fromInt(0xff000000);
    PdfColor greyColor = PdfColor.fromInt(0xffF7F7F7);
    final fontNormal = pw.FontWeight.normal;

    pw.Widget staffInfoTile({required String title, required String trailing}) {
      final bodyMedium = pw.TextStyle(fontSize: VSizes.fontSizeSm, color: greyColor, fontWeight: fontNormal,);
      return pw.Padding(
        padding: pw.EdgeInsets.symmetric(horizontal: VSizes.defaultSpace, vertical: VSizes.smallSpace),
        child: pw.Row(
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: VSizes.fontSizeMd, color: darkColor, fontWeight: fontNormal,),
          ),
          pw.Spacer(),
          pw.Text(
            trailing,
            style: bodyMedium,
          ),
        ]
        ));
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: VSizes.defaultSpace),
                child: pw.Row(
                  children: [
                    pw.ClipRRect(
                        verticalRadius:VSizes.mdBRadius,
                        horizontalRadius:VSizes.mdBRadius,
                        child: pw.Image(
                          netImage,
                          height: VDeviceUtils.screenWidth * 0.2,
                          width: VDeviceUtils.screenWidth * 0.2,
                          fit: pw.BoxFit.cover,
                        )
                    ),
                    pw.SizedBox(width: VSizes.spaceBtwItems,),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '${staff.firstname} ${staff.lastname}',
                          style: pw.TextStyle(fontSize: 16, color: PdfColor.fromInt(0xff000000), fontWeight: pw.FontWeight.normal,),
                        ),

                        pw.Text(staff.role??'Staff Member', style: pw.TextStyle(fontSize: VSizes.fontSizeSm, color:  greyColor, fontWeight: pw.FontWeight.normal,), ),
                      ],
                    )
                  ],
                ),
              ),
              pw.SizedBox(height: VSizes.defaultSpace,),
              staffInfoTile(title: 'Staff ID', trailing: staff.staffID!),
              staffInfoTile(title: 'Email', trailing: staff.email!),
              staffInfoTile(title: 'Phone No.', trailing: staff.mobileNo!),
              staffInfoTile(title: 'Department', trailing: staff.department!),
              pw.SizedBox(height: VSizes.spaceBtwSections,),
              if(qrImage!=null)pw.Image(pw.MemoryImage(qrImage), width: 200, height: 200)
             ] );


        },
      ),
    );

    return await pdf.save();
  }

  Future<void> savePdf() async {
    try {
      generatingPdf.value = true;
      final pdfData = await generatePdf();
      await FileSaver.instance.saveFile(
        name: 'staff_details_${staff.firstname!+staff.lastname!}.pdf',
        bytes: pdfData,
        ext: 'pdf',
        mimeType: MimeType.pdf,
      );
      VHelperFunc.snackBarNotifier(msg: 'Saved to documents');
    } catch (e) {
      VHelperFunc.errorNotifier('Error saving PDF: $e');
    }
    generatingPdf.value = false;
  }
}