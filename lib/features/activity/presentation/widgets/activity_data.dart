class ActivityData {
  final String status;
  final String title;
  // Add other fields you'd get from the API
  // e.g., final double amount; final DateTime scheduleTime;
  
  ActivityData({required this.status, required this.title});
}

// Create sample lists of data for each category
final List<ActivityData> allActivities = [
  ActivityData(status: 'PAID', title: 'Payment Received – PET Plastic Bottles'),
  ActivityData(status: 'SCHEDULED', title: 'Pickup Scheduled – PET Plastic Bottles'),
  ActivityData(status: 'COMPLETED', title: 'Pickup Completed – Glass Waste'),
  ActivityData(status: 'PAID', title: 'Payment Received – Iron Scraps'),
];

// In a real app, you would filter a single master list.
// For this example, we'll create separate lists to be clear.
final List<ActivityData> paidActivities = allActivities.where((a) => a.status == 'PAID').toList();
final List<ActivityData> scheduledActivities = allActivities.where((a) => a.status == 'SCHEDULED').toList();
final List<ActivityData> completedActivities = allActivities.where((a) => a.status == 'COMPLETED').toList();