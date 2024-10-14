import 'package:enjoy_plus_hm/utils/http.dart';
import 'package:enjoy_plus_hm/utils/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  String apiKey = 'ec6f580a9ed57f6731978c15a3a50fb1';
  String baseUrl = 'https://restapi.amap.com/v3';

  // 地址和周边小区
  String currentAddress = '';
  List nearbyCommunity = [];

  @override
  void initState() {
    super.initState();
    // 1. 检测是否配置位置授权
    requestLocationPermission();

    reverseGeocoding(40.065956, 116.350077);
    queryNearbyCommunities(40.065956, 116.350077);
  }

  /// 检测是否配置位置授权
  Future<void> requestLocationPermission() async {
    try {
      PermissionStatus status = await Permission.location.request();
      if (status.isGranted) {
        ToastUtil.showSuccess('位置授权成功');
        getCurrentLocation();
        // reverseGeocoding(40.065956, 116.350077);
      } else {
        ToastUtil.showError('位置授权失败');
      }
    } catch (e) {
      print(e);
    }
  }

  /// 获取当前位置的经纬度
  Future<void> getCurrentLocation() async {
    late LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      // 针对Android平台，设置高精度定位、100米距离过滤、强制使用位置管理器等
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      // 针对iOS和macOS平台，设置高精度定位、健身活动类型、100米距离过滤等
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // 只有在应用在后台启动时才设置为true
        showBackgroundLocationIndicator: false,
      );
    } else if (kIsWeb) {
      // 针对Web环境，设置高精度定位、100米距离过滤、5分钟的最大年龄等
      locationSettings = WebSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        maximumAge: const Duration(minutes: 5),
      );
    } else {
      // 对于其他平台，默认设置高精度定位和100米距离过滤
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      ToastUtil.showSuccess('经纬度：${position.latitude},${position.longitude}');
      // TODO: 使用经纬度进行定位
      // reverseGeocoding(position.latitude, position.longitude);
    } catch (e) {
      print(e);
      ToastUtil.showError('获取经纬度出现为题');
    }
  }

  /// 逆地址解析
  Future<void> reverseGeocoding(double latitude, double longitude) async {
    try {
      var res = await http.get(
          '$baseUrl/geocode/regeo?key=$apiKey&location=$longitude,$latitude');
      setState(() {
        currentAddress = res['regeocode']['formatted_address'];
      });
    } catch (e) {
      print(e);
      ToastUtil.showError('逆地址解析出现为题');
    }
  }

  /// 获取附近小区
  Future<void> queryNearbyCommunities(double latitude, double longitude) async {
    try {
      var res = await http.get(
          '$baseUrl/place/around?key=$apiKey&location=$longitude,$latitude&radius=500&types=住宅小区');
      setState(() {
        nearbyCommunity = res['pois'];
      });
    } catch (e) {
      print(e);
      ToastUtil.showError('获取附近小区出现问题');
    }
  }

  /// 构建小区列表
  List<Widget> _buildCommunityItem(List community) {
    List<Widget> temp = [];
    for (var item in community) {
      temp.add(GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/building_list', arguments: {
               // 小区的名称
              'point': item['name']
            });
          },
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                Expanded(child: Text('${item['name']}')),
                const Row(children: [
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
                ])
              ]))));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('选择社区'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const Row(
              children: [
                Text(
                  '当前地址',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(child: Text(currentAddress)),
                  GestureDetector(
                      onTap: () {
                        reverseGeocoding(40.065956, 116.350077);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.location_searching_outlined,
                              color: Colors.blue),
                          SizedBox(width: 2),
                          Text(
                            '重新定位',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  '附近社区',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(height: 10),
            ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: _buildCommunityItem(nearbyCommunity))
          ],
        ));
  }
}
