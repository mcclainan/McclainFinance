<%@ page import="com.access.UserInfo" %>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Login</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon"
			href="${resource(dir: 'images', file: 'favicon.png')}"
			type="image/x-icon">
		<link rel="apple-touch-icon"
			href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114"
			href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet"
			href="${resource(dir: 'css', file: 'macfin.css')}" type="text/css">
		<link rel="stylesheet"
			href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<style type="text/css">
			#outer{
				width:37em;
			}
			#primaryContentContainer {
				margin:0 10em;
			}
			#submit{
				width:5em;
			}
			#tdsubmit{
				text-align: center;
			}
			.label{
				width:2em;
			}
			table{
				width:30em;
			}
			
		</style>
	</head>
<body>
<div id="outer">
		<div id="header">
			<a class="home" href="${createLink(uri: '/')}"><img
				src="${resource(dir: 'images', file: 'grails_logo.png')}"
				alt="Grails" class="logo" /></a>
		</div>
		
		<div id="menu">
		</div>
		<div id="primaryContentContainer">
			<div id="primaryContent">
				<g:if test="${errors}">
					<ul class="errors" role="alert">
						<g:each in="${errors}" var="error">
							<li>${error.value}</li>
						</g:each>
					</ul>
				</g:if>
				<form action="signin">
					<fieldset class="form">
						<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'name', 'error')} required">
							<label for="name">
								User Name
								<span class="required-indicator">*</span>
							</label>
							<g:field type="text" name="name"/>
						</div>
						<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'password', 'error')} required">
							<label for="password">
								Password
								<span class="required-indicator">*</span>
							</label>
							<g:field type="password" name="password"/>
						</div>
					</fieldset>
					<fieldset class="buttons">
						<g:submitButton name="submit" value="login"/>
					</fieldset>
				</form>
				
			</div>
		</div>
	</div>
	
</body>
</html>