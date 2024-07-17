<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP initial version 06/2024

	Dependance:
		header - head
		style - generalStyle, bodyStyleCss
		recordTitle - SLSP-multilingual, SLSP-greeting
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<!--Fix to transform the note coming from Alma UI to insert new lines
		Takes the parameter text and replaces new lines with <br/> 
	Source: https://stackoverflow.com/questions/561235/xslt-replace-n-with-br-only-in-one-node
		@Tomalak, CC-BY-SA 3.0
	-->
	<xsl:template name="break">
		<xsl:param name="text" select="string(.)"/>
		<xsl:choose>
			<xsl:when test="contains($text, '&#xa;')">
			<xsl:value-of select="substring-before($text, '&#xa;')"/>
			<br/>
			<xsl:call-template name="break">
				<xsl:with-param 
				name="text" 
				select="substring-after($text, '&#xa;')"
				/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
			<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

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

				<br />

				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							<xsl:call-template name="SLSP-greeting" />
						</td>
					</tr>
					<tr>
						<td>
							@@you_are_assign@@ <xsl:value-of select="notification_data/owner/first_name"/>&#160;<xsl:value-of select="notification_data/owner/last_name"/>@@mr_mrs@@
					   </td>
					</tr>
					<tr>
						<td>
							<strong><xsl:call-template name="SLSP-multilingual">
								<xsl:with-param name="en" select="'Task:'" />
								<xsl:with-param name="fr" select="'Tâche :'" />
								<xsl:with-param name="it" select="'Attività:'" />
								<xsl:with-param name="de" select="'Aufgabe:'" />
							</xsl:call-template></strong>&#160;<xsl:value-of select="/notification_data/assigned_object"/>
							<br />
							<strong><xsl:call-template name="SLSP-multilingual">
								<xsl:with-param name="en" select="'Task name: '" />
								<xsl:with-param name="fr">
									<![CDATA[Nom de la tâche : ]]>
								</xsl:with-param>
								<xsl:with-param name="it">
									<![CDATA[Nome dell'attività: ]]>
								</xsl:with-param>
								<xsl:with-param name="de" select="'Aufgabenname: '" />
							</xsl:call-template></strong><xsl:value-of select="/notification_data/assigned_object_name"/>
							<xsl:if test="notification_data/note != ''">
								<br />
								<strong>@@note@@: </strong>
								<xsl:call-template name="break">
									<xsl:with-param name="text" select="/notification_data/note"/>
								</xsl:call-template>
							</xsl:if>	
						</td>
					</tr>
					
					<tr>
						<td>
							@@sincerely@@
						</td>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="notification_data/organization_unit/name" />
						</td>
					</tr>
				</table>
				<!-- <xsl:call-template name="lastFooter" /> --><!-- footer.xsl -->
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>