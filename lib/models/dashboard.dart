// To parse this JSON data, do
//
//     final dashboard = dashboardFromJson(jsonString);

import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  int? mechanics;
  int? completed;
  int? pending;
  int? waitingForParts;
  int? inProgress;
  int? noShow;
  int? cancelled;

  Dashboard({
    this.mechanics,
    this.completed,
    this.pending,
    this.waitingForParts,
    this.inProgress,
    this.noShow,
    this.cancelled,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        mechanics: json["mechanics"],
        completed: json["completed"],
        pending: json["pending"],
        waitingForParts: json["waiting-for-parts"],
        inProgress: json["in-progress"],
        noShow: json["no-show"],
        cancelled: json["cancelled"],
      );

  Map<String, dynamic> toJson() => {
        "mechanics": mechanics,
        "completed": completed,
        "pending": pending,
        "waiting-for-parts": waitingForParts,
        "in-progress": inProgress,
        "no-show": noShow,
        "cancelled": cancelled,
      };
}
