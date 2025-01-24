<#import "template.ftl" as layout>
    <@layout.registrationLayout bodyClass="oauth" ; section>
        <#if section="header">
            <!-- Vídeo de fundo -->
            <div class="kc-video-background">
                <video autoplay muted loop id="background-video">
                    <source src="${url.resourcesPath}/videos/background-video.mp4" type="video/mp4">
                    Seu navegador não suporta o elemento de vídeo.
                </video>
            </div>
            <#elseif section="form">
                <div>
                    <h3>
                        ${msg("oauthGrantRequest")}
                    </h3>
                    <ul>
                        <#if oauth.clientScopesRequested??>
                            <#list oauth.clientScopesRequested as clientScope>
                                <li>
                                    <span>
                                        <#if !clientScope.dynamicScopeParameter??>
                                            ${advancedMsg(clientScope.consentScreenText)}
                                            <#else>
                                                ${advancedMsg(clientScope.consentScreenText)}: <b>
                                                    ${clientScope.dynamicScopeParameter}
                                                </b>
                                        </#if>
                                    </span>
                                </li>
                            </#list>
                        </#if>
                    </ul>
                    <#if client.attributes.policyUri?? || client.attributes.tosUri??>
                        <h3 class="tos-link">
                            <#if client.name?has_content>
                                ${msg("oauthGrantInformation",advancedMsg(client.name))}
                                <#else>
                                    ${msg("oauthGrantInformation",client.clientId)}
                            </#if>
                            <#if client.attributes.tosUri??>
                                    ${msg("oauthGrantReview")}
                                <a href="${client.attributes.tosUri}" target="_blank" class="tos-link">
                                    ${msg("oauthGrantTos")}
                                </a>
                            </#if>
                            <#if client.attributes.policyUri??>
                                ${msg("oauthGrantReview")}
                                <a href="${client.attributes.policyUri}" target="_blank" class="tos-link">
                                    ${msg("oauthGrantPolicy")}
                                </a>
                            </#if>
                        </h3>
                    </#if>
                    <form  action="${url.oauthAction}" method="POST">
                        <input type="hidden" name="code" value="${oauth.code}">
                        <div>
                            <div>
                                <div>
                                    <input class="button-sucess" name="accept" type="submit" value="${msg("doYes")}" />
                                    <input class="button-warning" name="cancel" type="submit" value="${msg("doNo")}" />
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="clearfix"></div>
                </div>
        </#if>
    </@layout.registrationLayout>