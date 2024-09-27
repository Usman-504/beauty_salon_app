import 'package:beauty_salon/UI/screens/admin-ui/bottom_nav_bar/admin_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../generated/assets.dart';
import '../../../components/custom_button.dart';
import '../AppointmentSummary/appointment_summary.dart';
import '../bottom_nav_bar/book_appointment/book_appointment_provider.dart';
import '../bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';
import '../bottom_nav_bar/services/all_services/all_services.dart';
import 'booking_provider.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<BookAppointmentProvider>().getRole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final bookAppointmentProvider =
    Provider.of<BookAppointmentProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: kContainerColor,
        appBar: AppBar(
          bottom: TabBar(
            labelColor: kContainerColor,
            unselectedLabelColor: kSecondaryColor,
            tabs: [
              Tab(text: 'Pending', icon: Icon(Icons.hourglass_bottom)),
              Tab(text: 'UpComing', icon: Icon(Icons.add_task)),
              Tab(text: 'Past', icon: Icon(Icons.alarm)),
              Tab(text: 'Rejected', icon: Icon(Icons.close)),
            ],
          ),
          backgroundColor: kPrimaryColor,
          leading: GestureDetector(
            onTap: () {
              bookAppointmentProvider.role == 'admin'
                  ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminBottomNavBar()))
                  : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBar()));
            },
            child: Icon(
              Icons.arrow_back,
              size: heightX * 0.04,
              color: kWhiteColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            'All Bookings',
            style: secondaryTextStyle.copyWith(
                color: kWhiteColor, fontSize: widthX * 0.062),
          ),
        ),
        body: TabBarView(
          children: [
            _buildBookingList(context, bookAppointmentProvider.getPendingAppointments()),
            _buildBookingList(context, bookAppointmentProvider.getUpComingAppointments()),
            _buildBookingList(context, bookAppointmentProvider.getPastAppointments()),
            _buildBookingList(context, bookAppointmentProvider.getRejectedAppointments()),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList(BuildContext context, Stream bookingStream) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;
    final bookAppointmentProvider = Provider.of<BookAppointmentProvider>(context);

    return StreamBuilder(
      stream: bookingStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error occurred'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.emptyBooking,
                    height: heightX * 0.35,
                  ),
                  Text(
                    'No booking yet',
                    style: primaryTextStyle.copyWith(
                        color: kPrimaryColor, fontSize: widthX * 0.085),
                  ),
                  Text(
                    bookAppointmentProvider.role == 'admin'
                        ? 'When a user books a service, you can find their booking details here.'
                        : 'When you book a service, you can find your booking details here.',
                    textAlign: TextAlign.center,
                    style: smallTextStyle.copyWith(
                        color: kPrimaryColor,
                        fontSize: widthX * 0.042,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: heightX * 0.03,
                  ),
                  bookAppointmentProvider.role == 'admin'
                      ? SizedBox.shrink()
                      : CustomButton(
                    height: heightX * 0.06,
                    width: widthX * 0.7,
                    text: 'Add Service',
                    borderRadius: 10,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllServices()));
                    },
                    style: mediumTextStyle,
                    btnColor: kPrimaryColor,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var booking = snapshot.data!.docs[index];
            return Padding(
              padding: EdgeInsets.all(widthX * 0.03),
              child: Container(
                height: heightX * 0.12,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(widthX * 0.03),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: heightX * 0.1,
                        width: widthX * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(booking['image_url'])),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            booking['service_name'],
                            style: mediumTextStyle.copyWith(
                                color: kPrimaryColor),
                          ),
                          Text(
                            booking['service_type'],
                            style: smallTextStyle.copyWith(
                                color: kPrimaryColor),
                          ),
                          Text(
                            booking['appointment_date'],
                            style: smallTextStyle.copyWith(
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentSummary(
                                    serviceName: booking['service_name'],
                                    servicePrice: booking['service_price'],
                                    totalPrice: booking['total_price'],
                                    time: booking['appointment_time'],
                                    date: booking['appointment_date'],
                                    serviceType: booking['service_type'],
                                    imageUrl: booking['image_url'],
                                    customerName: booking['customer_name'],
                                    customerAddress: booking['customer_address'],
                                    customerNumber: booking['customer_number'],
                                    customerMessage: booking['customer_message'],
                                    appointmentStatus: booking['appointment_status'],
                                    docId: booking.id,
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.more_vert),
                          ),
                          Text(
                            'Rs. ${booking['service_price']}/-',
                            style: smallTextStyle.copyWith(
                                color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

