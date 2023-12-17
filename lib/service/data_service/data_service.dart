class DataService {
  List<Map<String, dynamic>> status = [
    {
      "label": "Pending",
      "value": "Pending",
    },
    {
      "label": "Ongoing",
      "value": "Ongoing",
    },
    {
      "label": "Review",
      "value": "Review",
    },
    {
      "label": "Done",
      "value": "Done",
    }
  ];

  List<Map<String, dynamic>> roles = [
    {
      "label": "Admin",
      "value": "Admin",
    },
    {
      "label": "User",
      "value": "User",
    }
  ];
}

var ds = DataService();
