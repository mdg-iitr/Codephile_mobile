import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:codephile/resources/colors.dart';

class SubmissionCard extends StatelessWidget {
  final String _username;
  final String _handle;
  final String _time;
  final String _problem;
  final String _platform;
  final String _picture;

  final Widget contestIcon = new SvgPicture.asset(
    "assets/solved.svg",
    color: const Color.fromRGBO(152, 219, 17, 1),
    width: 12.0,
    height: 12.0,
  );

  final Widget bookmark = new SvgPicture.asset(
    "assets/bookmark.svg",
    width: 14.0,
    height: 14.0,
  );

  SubmissionCard(this._username, this._handle, this._platform, this._problem,
      this._time, this._picture);

  @override
  Widget build(BuildContext context) {
    String time = getTime(_time);
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 2.0),
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.05),
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(2.0),
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(_picture),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _handle,
                              style: TextStyle(
                                color: const Color.fromRGBO(36, 36, 36, 1),
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Text(
                              _username,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.0, right: 5.0),
                        child: Text(
                          "Solved $time ago",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 3.0, 6.0),
                          child: Card(
                            elevation: 0.0,
                            color: codephileSolvedBackground,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: contestIcon,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 4.0, 5.0, 4.0),
                                  child: Text(
                                    'Solved',
                                    style: TextStyle(
                                      color: Color.fromRGBO(152, 219, 17, 1),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.6),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: bookmark,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 6.0, 24.0, 6.0),
                      child: Text(
                        "$_problem",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                          color: const Color.fromRGBO(36, 36, 36, 1),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 6.0, 6.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 0.0),
                            child: Image.asset(
                              getIconUrl(_platform),
                              width: 23.0,
                              height: 23.0,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0.0, 2.0, 0.0),
                            child: Text(
                              "$_platform",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getTime(String time) {
    final solvedTime = DateTime.parse(time);
    final nowTime = DateTime.now();
    final diff = nowTime.difference(solvedTime).inMinutes;
    if (diff < 1) {
      return nowTime.difference(solvedTime).inSeconds.toString() + " secs";
    } else if (diff < 60) {
      return diff.toString() + " mins";
    } else if (diff >= 60 && diff < 1440) {
      //1440 = 60*24
      return nowTime.difference(solvedTime).inHours.toString() + " hrs";
    } else if (diff >= 1440 && diff < 1440 * 30) {
      return nowTime.difference(solvedTime).inDays.toString() + " days";
    } else if (diff >= 1440 * 30 && diff < 1440 * 30 * 12) {
      return (nowTime.difference(solvedTime).inDays ~/ 30).toString() +
          " months";
    } else {
      int years = (nowTime.difference(solvedTime).inDays ~/ (30 * 12));
      return years.toString() + ((years > 1) ? " years" : " year");
    }
  }

  String getIconUrl(String platform) {
    final String codeChefIcon = "assets/platformIcons/codeChefIcon.png";
    final String hackerRankIcon = "assets/platformIcons/hackerRankIcon.png";
    final String hackerEarthIcon = "assets/platformIcons/hackerEarthIcon.png";
    final String codeForcesIcon = "assets/platformIcons/codeForcesIcon.png";
    final String spojIcon = "assets/platformIcons/spoj.png";
    final String otherIcon = "assets/platformIcons/otherIcon.jpg";

    switch (platform.toLowerCase()) {
      case "codechef":
        return codeChefIcon;
        break;
      case "hackerrank":
        return hackerRankIcon;
        break;
      case "hackerearth":
        return hackerEarthIcon;
        break;
      case "codeforces":
        return codeForcesIcon;
        break;
      case "spoj":
        return spojIcon;
        break;
      default:
        return otherIcon;
    }
  }
}
