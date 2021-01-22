<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl - 20200918, SLSP -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="recordTitle.xsl" />

	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
				<xsl:call-template name="head" /> <!-- header.xsl -->


				<div class="messageArea">
					<div class="messageBody">
                        <br/>
                        <br/>
						<table cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
                                    @@we_sent@@ <xsl:value-of select="/notification_data/request/create_date"/>.
                                </td>
                            </tr>				
							<tr>
								<td>
                                    <b>@@following_details@@: </b>
                                </td>
                            </tr>				
							<tr>
								<td>
                                    Author: <xsl:value-of select="notification_data/phys_item_display/author"/><br />
                                    Title: <xsl:value-of select="notification_data/phys_item_display/title"/><br />
                                    Barcode: <xsl:value-of select="notification_data/phys_item_display/barcode"/><br />
                                    Call Number: <xsl:value-of select="notification_data/phys_item_display/call_number"/>
                                </td>
                            </tr>				
							<tr>
								<td>
                                    <b>@@delivered_to@@: </b>
                                    <xsl:value-of select="substring-after(notification_data/delivery_address,':')" /> 
                                </td>
                            </tr>		
							<tr>
								<td>
									<b>@@due_date@@: </b>
									<xsl:value-of select="substring(notification_data/due_date,1,10)" />
                                </td>
                            </tr>
                        </table>
						<br />
						<table>

							<tr>
								<td>@@sincerely@@<br/>
							        <xsl:value-of select="notification_data/organization_unit/name" /></td></tr>


                                                       <tr>
                                                       <td><br/><i>powered by SLSP</i></td>
                                                       </tr>



						</table>
					</div>
				</div>
				
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
