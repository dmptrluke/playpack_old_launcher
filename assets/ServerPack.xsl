<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:x="http://www.mcupdater.com" exclude-result-prefixes="x">

    <xsl:template match="/">
        <html>
			<head>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<link href="./bootstrap/bootstrap.min.css" rel="stylesheet" />
				<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
				<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
				<!--[if lt IE 9]>
					<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
					<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
				<![endif]-->
			</head>
            <body>
				<div class="container">
                <xsl:for-each select="x:ServerPack/x:Server">
					<a id="{@id}"></a>
					<div class="page-header">
						<h1>
							<xsl:if test="@iconUrl">
								<img style="width: 100px; height: 100px; margin-right: 15px;" class="img-rounded" src="{@iconUrl}" alt="..." />
							</xsl:if>
							<xsl:if test="not(@iconUrl)">
								<img style="width: 100px; height: 100px; margin-right: 15px;" class="img-rounded" src="unknown.png" alt="..." />
							</xsl:if>
							<xsl:value-of select="@id"/> - <xsl:value-of select="@name"/> 
							<small> Minecraft <xsl:value-of select="@version"/> (revision <xsl:value-of select="@revision"/>)</small>
						</h1>
					</div>
                    <xsl:if test="count(x:Import)>0">
						<h2>Imported ServerPacks</h2>
						<table class="table">
							<thead>
								<tr>
									<th>Id</th>
									<th>URL</th>
								</tr>
							</thead>
							<tbody>
								<xsl:for-each select="x:Import">
									<tr>
										<td><xsl:value-of select="."/></td>
										<td><a href="{@url}"><xsl:value-of select="@url"/></a></td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</xsl:if>
					<h2>Module Index</h2>
						<table class="table table-striped">
							<colgroup>
								<col class="col-xs-9" />
								<col class="col-xs-3" />
							</colgroup>
							<thead>
								<tr>
									<th>Name</th>
									<th>ID</th>
								</tr>
							</thead>
							<tbody>
								<xsl:for-each select="x:Module">
									<tr>
										<td><xsl:value-of select="@name"/></td>
										<td><a href="#{@id}" data-toggle="collapse" data-target="#collapse-{@id}"><xsl:value-of select="@id"/></a></td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
                    <h2>
					Module Details
					<div class="btn-group pull-right">
						<a id="expand-all" class="btn btn-default">Expand All</a> 
						<a id="collapse-all" class="btn btn-default">Collapse All</a>
					</div>
					</h2>
					<div class="panel-groupH" id="modules">
						<xsl:for-each select="x:Module">
						<div class="panel panel-default">
							<a name="{@id}"></a>
							<div class="panel-heading">
								<h3 class="panel-title">
								<a data-toggle="collapse" data-target="#collapse-{@id}"> 
									<strong><xsl:value-of select="@id"/></strong> - <xsl:value-of select="@name"/>
									<xsl:if test="@Meta/version">
										<span class="label label-info pull-right">?</span>
									</xsl:if>
								</a>
								</h3>
							</div>
							<div id="collapse-{@id}" class="panel-collapse collapse module-panel">
							<div class="panel-body">
							<table class="table">
							    <colgroup>
									<col class="col-xs-7" />
									<col class="col-xs-1" />
									<col class="col-xs-4" />
								</colgroup>
								<thead>
									<tr>
										<th>URL</th>
										<th>Type</th>
										<th>MD5</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><a href="{x:URL}"><xsl:value-of select="x:URL"/></a></td>
										<td><xsl:value-of select="x:ModType"/></td>
										<td><xsl:value-of select="x:MD5"/></td>
									</tr>

								</tbody>
							</table>
							<xsl:if test="count(x:Meta)>0">
								<table class="table table-hover">
									<colgroup>
										<col class="col-xs-2" />
										<col class="col-xs-10" />
									</colgroup>
									<thead>
										<tr>
											<th>Meta</th>
											<th>Details</th>
										</tr>
									</thead>
									<tbody>
										<xsl:for-each select="x:Meta/*">
											<tr>
												<td><xsl:value-of select ="local-name()"/></td>
												<xsl:if test="local-name() = 'URL'">
													<td><a href="{.}"><xsl:value-of select="."/></a></td>
												</xsl:if>
												<xsl:if test="not(local-name() = 'URL')">
													<td><xsl:value-of select="."/></td>
												</xsl:if>
											</tr>
										</xsl:for-each>
									</tbody>
								</table>
							</xsl:if>
							<xsl:if test="count(x:ConfigFile)>0">
								<table class="table table-condensed table-hover">
									<colgroup>
										<col class="col-xs-5" />
										<col class="col-xs-6" />
										<col class="col-xs-1" />
									</colgroup>
									<thead>
										<tr>
											<th>Path</th>
											<th>URL</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<xsl:for-each select="x:ConfigFile">
											<tr>
												<td style="vertical-align:middle"><xsl:value-of select="x:Path"/></td>
												<td style="vertical-align:middle"><a href="{x:URL}"><xsl:value-of select="x:URL"/></a><a class="modal_link" data-toggle="modal" href="{x:URL}">View</a></td>
												<td>
													<button type="button" class="btn btn-default btn-sm" data-container="body" data-toggle="popover" data-placement="left" data-content="{x:MD5}" data-original-title="" title="">Show MD5</button>
												</td>
											</tr>
										</xsl:for-each>
									</tbody>
								</table>

							</xsl:if>
							</div>
							
							
							
						</div></div>
					</xsl:for-each>
					</div>
                    <hr/>
						
                </xsl:for-each>
				<p>
					XSL sheet designed by <a>Luke Rogers</a> - Powered by <a href="http://mcupdater.com/">McUpdater</a> ServerPack version <xsl:value-of select="x:ServerPack/@version"/>.
				</p>
			</div>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
			<script src="./bootstrap/bootstrap.min.js"></script>
			<script>
$('#collapse-all').click(function () {
  $('.module-panel').collapse('hide');
});

$('#expand-all').click(function () {
  $('.module-panel').collapse('show');
});
$('button').popover();

</script>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
