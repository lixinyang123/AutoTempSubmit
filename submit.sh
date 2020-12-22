if [ -f "info.json" ]; then
	phone=$(jq -r .phone info.json)
	token=$(jq -r .token info.json)

	# 提交今日体温
	# para (Method: POST) [
	#     axy-phone = <PhoneNumber>
	#     axy-token = <LoginResponse.data>
	# ]
	status=$(curl -X POST \
		"http://zzife.zhidiantianxia.cn/api/study/health/mobile/temp/report" \
		-H "Content-Type: application/json" \
		-H "axy-phone: ${phone}" \
		-H "axy-token: ${token}" \
		-d "{\"temperature\": \"36.6\", \"health\": \"0\", \"abnormal\": \"\"}")

	# # 提交健康日志
	# # para (Method: POST) [
	# #     axy-phone = <PhoneNumber>
	# #     axy-token = <LoginResponse.data>
	# # ]
	# status=$(curl -X POST \
	# 	"http://zzife.zhidiantianxia.cn/api/study/health/apply" \
	# 	-H "Content-Type: application/json" \
	# 	-H "axy-phone: ${phone}" \
	# 	-H "axy-token: ${token}" \
	# 	-d "{"health":0,"student":"1","content":"{\"location\":{\"address\":\"学校\",\"code\":\"1\",\"lng\":113.598399,\"lat\":34.862548},\"name\":\"姓名\",\"phone\":\"手机号\",\"credentialType\":\"身份证\",\"credentialCode\":\"身份证号码\",\"college\":\"信息工程学院\",\"major\":\"软件工程\",\"className\":\"软工6班\",\"code\":\"学号\",\"nowLocation\":\"河南省-郑州市-惠济区\",\"temperature\":\"36.6\",\"observation\":\"否\",\"confirmed\":\"否\",\"goToHuiBei\":\"否\",\"contactIllPerson\":\"否\",\"isFamilyStatus\":\"否\",\"health\":0}"}")

	if [ $(echo ${status} | jq -r .status)==1 ]; then
		echo "提交成功"
	else
		echo "提交失败"

		# 终止 Github Action 发送错误邮件
		bash ./error.sh
	fi

	echo ${status}

else
	echo "请先执行 login.sh 登录"
fi
