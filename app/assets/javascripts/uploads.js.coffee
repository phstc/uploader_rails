$ ->
	uploaderURL = "http://ec2-23-22-70-95.compute-1.amazonaws.com"
	socket = io.connect "#{uploaderURL}:80"
	socket.on 'connect', ->
		formAction = "#{uploaderURL}/upload?socketid=#{socket.socket.sessionid}"
		formAction += "&security_hash=#{$('#form_upload').data('security_hash')}"
		formAction += "&timestamp=#{$('#form_upload').data('timestamp')}"

		$('#form_upload').attr 'action', formAction

		socket.on 'upload_percentage', (percentage) ->
			showUploadPercentage(percentage)
			
		socket.on 'upload_error', (message) ->
			showUploadError(message)

		socket.on 'uploaded_file', (file) ->
			showUploadFilePath(file)

	$('#upload').change ->
		showUploadPercentage 0
		showUploadFilePath()
		$('#form_upload').submit()

	showUploadPercentage = (percentage) ->
		$('#upload_percentage').html "#{percentage}%"
		
	showUploadError = (message) ->
		$('#upload_error').html message

	showUploadFilePath = (file) ->
		filePath = ''
		if file
			fullFilePath = "#{uploaderURL}#{file.path}" 
			$('#upload_file_url').val fullFilePath
			filePath = "<a href=\"#{fullFilePath}\">#{fullFilePath}</a>"
		$('#upload_file_path').html filePath
