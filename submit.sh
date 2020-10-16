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

	if [ $(echo ${status} | jq -r .status)==1 ]; then
		echo "提交成功"
	else
		echo "提交失败"
	fi

	echo ${status}

else
	echo "请先执行 login.sh 登录"
fi