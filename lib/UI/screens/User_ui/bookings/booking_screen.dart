import 'package:beauty_salon/UI/screens/admin-ui/bottom_nav_bar/admin_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/const_colors.dart';
import '../../../../core/constants/const_styles.dart';
import '../../../../generated/assets.dart';
import '../AppointmentSummary/appointment_summary.dart';
import '../bottom_nav_bar/book_appointment/book_appointment_provider.dart';
import '../bottom_nav_bar/bottom_nav_screen/bottom_nav_bar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int _currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    Future.microtask(() => context.read<BookAppointmentProvider>().getRole());
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            indicatorColor: kWhiteColor,
            controller: _tabController,
            labelColor: kContainerColor,
            unselectedLabelColor: kSecondaryColor,
            tabs: const [
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
                      builder: (context) => const AdminBottomNavBar()))
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
          controller: _tabController,
          children: [
           if(bookAppointmentProvider.role == 'client')...[
            _buildBookingList(context, bookAppointmentProvider.getPendingAppointments()),
            _buildBookingList(context, bookAppointmentProvider.getUpComingAppointments()),
            _buildBookingList(context, bookAppointmentProvider.getPastAppointments()),
            _buildBookingList(context, bookAppointmentProvider.getRejectedAppointments()),]
                else ... [
              _buildBookingList(context, bookAppointmentProvider.getAllPendingAppointments()),
              _buildBookingList(context, bookAppointmentProvider.getAllUpComingAppointments()),
              _buildBookingList(context, bookAppointmentProvider.getAllPastAppointments()),
              _buildBookingList(context, bookAppointmentProvider.getAllRejectedAppointments()),
            ]
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error occurred'));
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

                  // Image.asset(
                  //   Assets.emptyBooking,
                  //   height: heightX * 0.35,
                  // ),
                  Text(
                   'No Booking Found',
                    style: primaryTextStyle.copyWith(
                        color: kPrimaryColor, fontSize: widthX * 0.085),
                  ),
                  Text(
                    bookAppointmentProvider.role == 'admin' ? 'You haven\'t added any booking in this category' :
                    'You have no booking in this category',
                    textAlign: TextAlign.center,
                    style: smallTextStyle.copyWith(
                        color: kPrimaryColor,
                        fontSize: widthX * 0.042,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: heightX * 0.03,
                  ),
                 // button
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

