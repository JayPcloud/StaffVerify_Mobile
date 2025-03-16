import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:random_string/random_string.dart';
import 'package:staff_verify/data/services/qr_code_service.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/device.dart';
import '../../../utils/helpers/helper_func.dart';
import '../../staff_verification/models/staff_model.dart';
import 'package:open_file/open_file.dart';
//
// class PdfPreview extends StatelessWidget {
//   const PdfPreview({super.key});
//
//   Future<Uint8List> generateImagePreview() async {
//     final json = await VStaffRepositories().getStaff(VTexts.emailField, 'nwankwojohnpaul681@gmail.com');
//     final Staff staff = Staff.fromJson(json[0].data());
//     final doc = await VRegConfirmationController(staff: staff).openFile(staff);
//     print(staff);
//     final image = await doc.save();
//
//     return image;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: generateImagePreview(),
//           builder: (context, snapshot) {
//           if(snapshot.hasError){
//             return Center(child: Text(snapshot.error.toString()),);
//           }
//             if(snapshot.hasData) {
//               return Center(child: Text('data'),);
//             }else{
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//       ),
//     );
//   }
// }

class VRegConfirmationController extends GetxController {


  final Staff staff;
  VRegConfirmationController({required this.staff});

  RxBool generatingPdf = false.obs;

  ///---------------------PDF APIs------------------///

  Future<Uint8List> _loadAssetImage(String asset) async {
    final img = await rootBundle.load(asset);
    final imageBytes = img.buffer.asUint8List();
    return imageBytes;
  }


   Future<pw.Document> generatePdf() async {
    final pdf = pw.Document();

    final qrImage = await VQRCodeGenerator(qrData: staff.qrcodeData!).toUInt8List();
    final netImage = await networkImage(staff.imageUrl!);
    final appLogo = await _loadAssetImage(VTexts.appLogo);

    PdfColor darkColor = PdfColor.fromInt(0xff000000);
    PdfColor greyColor = PdfColor.fromInt(0xff656565);
    final fontNormal = pw.FontWeight.normal;

    pw.Widget staffInfoTile({required String title, required String trailing}) {
      final bodyMedium = pw.TextStyle(fontSize: VSizes.fontSizeSm, color: darkColor, fontWeight: fontNormal,);
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
              pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child:pw.Text('Staff Details', style: pw.TextStyle(fontSize: VSizes.fontSizeL, color:  darkColor, fontWeight: pw.FontWeight.bold,), ),

              ),
              pw.SizedBox(height: VSizes.spaceBtwSections,),
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
                        pw.SizedBox(width: VSizes.spaceBtwItems,),
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
              if(qrImage!=null)pw.Image(pw.MemoryImage(qrImage), width: 100, height: 100),
              pw.Spacer(),
              pw.Align(
                alignment: pw.Alignment.bottomLeft,
                child:  pw.Image(pw.MemoryImage(appLogo),width:40,height:40)
              )

             ] );
        },
      ),
    );

    return pdf;
  }

   Future<File?> saveDocument({required String name, required pw.Document pdf}) async {

     generatingPdf.value = true;

     final bytes = await pdf.save();

     final dir = await getApplicationDocumentsDirectory();
     final file = File('${dir.path}/$name');

     await file.writeAsBytes(bytes);

     VHelperFunc.snackBarNotifier(msg: 'Saved to documents');

     return file;

  }

   Future generateAndSavePdf() async {
     generatingPdf.value = true;
     try {
       final pdfDoc = await generatePdf();

       final file = await saveDocument(name: "${staff.firstname}_info${randomAlphaNumeric(4)}.pdf", pdf: pdfDoc);

       final url = file?.path;

       await OpenFile.open(url);

     } catch (e) {
       VHelperFunc.errorNotifier(VTexts.defaultErrorMessage);
     }
     generatingPdf.value = false;


  }

}