echo "输入设备码"
read deviceToken

echo "输入手机号"
read phone

# 获取验证码
# para (Method: POST) [
#     phone = <PhoneNumber>
#     type = 4
# ]
curl -X POST "http://app.zhidiantianxia.cn/api/common/sendVerifyCodeCheck?phone=${phone}&type=4"
echo

echo "输入验证码"
read verifyCode

# 验证码登录
# para (Method: POST) [
#     phone = <PhoneNumber>
#     code = <VerifyCode>
#     mobileSystem = <AndroidVersion> (eg. 8 || 9 || 10)
#     appVersion = 1.6.1
#     mobileVersion = <PhoneBrand> (eg. Nokia9 || Mi10 || OnePlue7)
#     deviceToken = <DeviceCode> (eg. 170976fa8a3b5568b17)
#     pushToken = <PhoneNumber>
# ]
token=$(curl -X POST "http://app.zhidiantianxia.cn/api/Login/phone?phone=${phone}&code=${verifyCode}&mobileSystem=9&appVersion=1.6.1&mobileVersion=Nokia9&deviceToken=${deviceToken}&pushToken=${phone}" | jq -r .data)
echo

# 密码登录
# para (Method: POST) [
#     phone = <PhoneNumber>
#     password = <Password> (default. 111111 加密？？？)
#     mobileSystem = <AndroidVersion> (eg. 8 || 9 || 10)
#     appVersion = 1.6.1
#     mobileVersion = <PhoneBrand> (eg. Nokia9 || Mi10 || OnePlue7)
#     deviceToken = <DeviceCode> (eg. 13065ffa4ebf829c0bf)
#     pushToken = <PhoneNumber>
# ]
# token=$(curl -X POST "http://app.zhidiantianxia.cn.api/Login/pwd?phone=${phone}&password=111111&mobileSystem=9&appVersion=1.6.1&mobileVersion=RMX&deviceToken=${deviceToken}&pushToken=${phone}" | jq -r .data)
# echo

# 提交今日体温
# para (Method: POST) [
#     axy-phone = <PhoneNumber>
#     axy-token = <LoginResponse.data>
# ]
curl -X POST \
	"http://zzife.zhidiantianxia.cn/api/study/health/mobile/temp/report" \
	-H "Content-Type: application/json" \
	-H "axy-phone: ${phone}" \
	-H "axy-token: ${token}" \
	-d "{\"temperature\": \"36.6\", \"health\": \"0\", \"abnormal\": \"\"}"