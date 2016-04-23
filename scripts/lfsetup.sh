#!/usr/bash

curl -u admin:admin -F file=@"Livefyre-AEM-Package.zip" -F name="Livefyre" \
-F force=true -F install=true http://$AEM_HOST:4502/crx/packmgr/service.jsp

curl -u admin:admin --data-binary "apply=true&action=ajaxConfigManager&$location=jcrinstall:/libs/cq/platform/install/cq-commons-5.8.32.jar&externalizer.domains=local http://aem.fyre:4502&externalizer.domains=author http://aem.fyre:4502&externalizer.domains=publish http://aem.fyre:4503&externalizer.host=&externalizer.contextpath=&propertylist=externalizer.domains,externalizer.host,externalizer.contextpath" \
--compressed http://$AEM_HOST:4502/system/console/configMgr/com.day.cq.commons.impl.ExternalizerImpl
