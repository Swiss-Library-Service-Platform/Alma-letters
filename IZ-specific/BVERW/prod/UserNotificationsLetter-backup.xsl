<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />
	<xsl:template match="/">
		<html>

			<head>
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>

				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" />
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" />
				<!-- header.xsl -->

	<!--TO -->
										<table role="presentation">
											<tr style="padding-top: 14px;">
												<td align="left" style="font-size:14px;">
													@@Dear@@
														<xsl:value-of select="/notification_data/receivers/receiver/user/first_name" />
                                                                                   <td align="left" style="font-size:14px;color:blue;background-color:red;">
														<xsl:value-of select="/notification_data/receivers/receiver/user/last_name" />,

<xsl:value-of select="/notification_data/user/user_type" />
									
                                                                                            </td>
                                                                                           </td>
											</tr>
										</table>
										<!--END TO -->

				<div class="messageArea">
					<div class="messageBody">

		
								
								<xsl:if test="notification_data/notification_type = 'NOTIFY_PASSWORD_CHANGE' ">

</xsl:if>
<xsl:template name="multilingual">
		<xsl:choose>
	<xsl:when test="//preferred_language='de'">
<table role='presentation' border="0" style="width:60%;font-size:14px;">	
				<tr> 	
        <td align="left" style=" padding-bottom: 14px;">      
Ändern Sie bitte Ihr Passwort.
                           
                              </td> 				
				</tr> 

                            <tr> 				
				<td align="left" style="padding-bottom: 14px;">
Bibliotheksverbund Alexandria/Bibliothek am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Bern<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a><br/>
                              </td> 				
				</tr>
				</table>
			</xsl:when>


			<xsl:when test="//preferred_language='fr'" >
<table role='presentation' border="0" style="width:60%;font-size:14px;">	
				<tr> 	
        <td align="left" style=" padding-bottom: 14px;">      
Veuillez changer votre mot de passe !
                           
                              </td> 				
				</tr> 

                            <tr> 				
				<td align="left" style="padding-bottom: 14px;">
Réseau de bibliothèques Alexandria / Bibliothèque Am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Berne<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a><br/>
                              </td> 				
				</tr>
				</table>
			</xsl:when>


			<xsl:when test="//preferred_language='it'" >
<table role='presentation' border="0" style="width:60%;font-size:14px;">	
		         <tr> 				
				<td align="left" style="padding-bottom: 14px;">
Grazie di cambiare il su password!
				</td> 				
				</tr> 
                            <tr> 				
				<td align="left" style="padding-bottom: 14px;">
Rete di biblioteche Alexandria/Biblioteca Am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Bern<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a><br/>
                              </td> 				
				</tr>
				</table>
			</xsl:when>

			<xsl:otherwise>
<table role='presentation' border="0" style="width:60%;font-size:14px;">	
		         <tr> 				
				<td align="left" style="padding-bottom: 14px;">
Please change you password!
				</td> 				
				</tr> 
				
                            <tr> 				
				<td align="left" style="padding-bottom: 14px;">
Bibliotheksverbund Alexandria/Bibliothek am Guisanplatz<br/>
Papiermühlestrasse 21a<br/>
CH-3003 Bern<br/>
Tel. +41 58 464 50 99<br/>
Mail: <a href="mailto:bibliothek@gs-vbs.admin.ch">bibliothek@gs-vbs.admin.ch</a><br/>
                              </td> 				
				</tr>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



						
						
						<br />
				<!--		<table role='presentation' >

							<tr>
								<td>@@Sincerely@@</td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="notification_data/organization_unit/name" />
								</td>
							</tr>
							<xsl:if test="notification_data/organization_unit/address/line1 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line1" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line2 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line2" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line3 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line3" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line4 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line4" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line5 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line5" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/city !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/city" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/country !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/country" />
									</td>
								</tr>

							</xsl:if>

						</table>-->
					</div>
				</div>
				<!--<xsl:call-template name="lastFooter" /> -->
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
