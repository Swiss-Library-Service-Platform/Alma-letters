<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
	<html>
			<xsl:if test="notification_data/languages/string">
				<xsl:attribute name="lang">
					<xsl:value-of select="notification_data/languages/string"/>
				</xsl:attribute>
			</xsl:if>

		<head>

		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<!--<xsl:call-template name="senderReceiver" /> --><!-- SenderReceiver.xsl -->

				<!--<xsl:call-template name="toWhomIsConcerned" /> --><!-- mailReason.xsl -->
					
				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
				<!--<tr>
					<td>
                        <br />
                        @@orderNumber@@	:

                            <br />

                    </td>
						<td>
				<br />
				<xsl:value-of  select="notification_data/line_number"/>

						<br />

					</td>
					</tr>-->
                <tr>
                    <td>
                        <br />
                        @@You_were_specify@@:
                        <br />
                    </td>
                </tr>
				<tr>
					<td>
                        <br />
                        <b>@@title@@:</b>
                        <br />
                        <xsl:value-of  select="notification_data/title"/>
                        <br />
					</td>
                </tr>
				<!--<tr>
					<td>
				<br />
				@@mmsId@@:

						<br />

					</td>
						<td>
				<br />
				<xsl:value-of  select="notification_data/mms_id"/>

						<br />

					</td>
					</tr>
					<tr>
					<td>
				<br />
				@@callNumber@@:

						<br />

					</td>
						<td>
				<br />
				<xsl:value-of  select="notification_data/poline_inventory/call_number"/>

						<br />

					</td>
					</tr>
				<tr>
					<td>
				<br />
				@@receivingNote@@:

						<br />

					</td>
						<td>
				<br />
				<xsl:value-of  select="notification_data/receiving_note"/>
						<br />

					</td>
				</tr>-->
                <tr>
					<td>
                        <br />
                        <b>@@message@@:</b>
                        <br />
                        <xsl:value-of  select="notification_data/message"/>
                        <br />
					</td>
                </tr>

				</table>
				<br />
				<table>
                    <tr>
                        <td>@@sincerely@@<br/>
                            <xsl:value-of select="notification_data/organization_unit/name" />
                        </td>
                    </tr>
                    <tr>
                        <td><br/><i>powered by SLSP</i></td>
                    </tr>
                </table>
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>