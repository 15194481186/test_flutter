import 'package:enjoy_plus_hm/utils/toast.dart';

class Validate {
  /// 校验手机号
  static bool validatePhone(String phone) {
    // 1. 手机号不能为空
    if (phone.isEmpty) {
      ToastUtil.showError('手机号不能为空');
      return false;
    }

    // 2. 格式校验
    RegExp reg = RegExp(r'^1[3-9]\d{9}$');
    if (!reg.hasMatch(phone)) {
      ToastUtil.showError('请输入正确的手机号');
      return false;
    }

    return true;
  }

  /// 校验姓名
  static bool validateName(String name) {
    // 1. 姓名不能为空
    if (name.isEmpty) {
      ToastUtil.showError('姓名不能为空');
      return false;
    }
    // 2. 姓名是2-10个中文
    RegExp reg = RegExp(r'^[\u4e00-\u9fa5]{2,10}$');
    if (!reg.hasMatch(name)) {
      ToastUtil.showError('请输入正确的姓名');
      return false;
    }

    return true;
  }

  /// 校验身份证正反面是否为空
  static bool validateIdcardImg(String idcardFrontUrl, String idcardBackUrl) {
    
    if (idcardFrontUrl.isEmpty || idcardBackUrl.isEmpty) {
      ToastUtil.showError('请上传身份证正反面');
      return false;
    }
    
    return true;
  }
}
