<#import "template.ftl" as layout>
    <#import "password-commons.ftl" as passwordCommons>
        <@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
            <!-- Vídeo de fundo -->
            <div class="kc-video-background">
                <video autoplay muted loop id="background-video">
                    <source src="${url.resourcesPath}/videos/background-video.mp4" type="video/mp4">
                    Seu navegador não suporta o elemento de vídeo.
                </video>
            </div>
            <#if section="header">
                <#elseif section="form">
                    <ol id="totp-settings">
                        <#if mode?? && mode="manual">
                            <li>
                                <p>
                                    ${msg("loginTotpManualStep2")}
                                </p>
                                <p><span id="totp-secret-key">
                                        ${totp.totpSecretEncoded}
                                    </span></p>
                                <p><a href="${totp.qrUrl}" id="mode-barcode">
                                        ${msg("loginTotpScanBarcode")}
                                    </a></p>
                            </li>
                            <li>
                                <p>
                                    ${msg("loginTotpManualStep3")}
                                </p>
                                <p>
                                <ul>
                                    <li id="totp-type">
                                        ${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}
                                    </li>
                                    <li id="totp-algorithm">
                                        ${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}
                                    </li>
                                    <li id="totp-digits">
                                        ${msg("loginTotpDigits")}: ${totp.policy.digits}
                                    </li>
                                    <#if totp.policy.type="totp">
                                        <li id="totp-period">
                                            ${msg("loginTotpInterval")}: ${totp.policy.period}
                                        </li>
                                        <#elseif totp.policy.type="hotp">
                                            <li id="totp-counter">
                                                ${msg("loginTotpCounter")}: ${totp.policy.initialCounter}
                                            </li>
                                    </#if>
                                </ul>
                                </p>
                            </li>
                            <#else>
                                <li>
                                    <p>
                                        ${msg("loginTotpStep2")}
                                    </p>
                                    <img id="totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br />
                                    <p><a href="${totp.manualUrl}" id="mode-manual">
                                            ${msg("loginTotpUnableToScan")}
                                        </a></p>
                                </li>
                        </#if>
                        <li>
                            <p>
                                ${msg("loginTotpStep3")}
                            </p>
                            <p>
                                ${msg("loginTotpStep3DeviceName")}
                            </p>
                        </li>
                    </ol>
                    <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
                        <div class="${properties.kcFormGroupClass!}">
                            <div class="${properties.kcInputWrapperClass!}">
                                <label for="totp" class="control-label">
                                    ${msg("authenticatorCode")}
                                </label> <span class="required">*</span>
                            </div>
                            <div class="${properties.kcInputWrapperClass!}">
                                <input type="text" id="totp" name="totp" autocomplete="off" class="${properties.kcInputClass!}"
                                    aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                                    dir="ltr" />
                                <#if messagesPerField.existsError('totp')>
                                    <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                            <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                            <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}" /></#if>
                        </div>
                        <div class="${properties.kcFormGroupClass!}">
                            <div class="${properties.kcInputWrapperClass!}">
                                <label for="userLabel" class="control-label">
                                    ${msg("loginTotpDeviceName")}
                                </label>
                                <#if totp.otpCredentials?size gte 1><span class="required">*</span></#if>
                            </div>
                            <div class="${properties.kcInputWrapperClass!}">
                                <input type="text" class="${properties.kcInputClass!}" id="userLabel" name="userLabel" autocomplete="off"
                                    aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>" dir="ltr" />
                                <#if messagesPerField.existsError('userLabel')>
                                    <span id="input-error-otp-label" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                        ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </div>
                        <div class="${properties.kcFormGroupClass!}">
                            <@passwordCommons.logoutOtherSessions />
                        </div>
                        <#if isAppInitiatedAction??>
                            <input type="submit"
                                class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                                id="saveTOTPBtn" value="${msg("doSubmit")}" />
                            <button type="submit"
                                class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!} ${properties.kcButtonLargeClass!}"
                                id="cancelTOTPBtn" name="cancel-aia" value="true" />
                            ${msg("doCancel")}
                            </button>
                            <#else>
                                <input type="submit"
                                    class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                                    id="saveTOTPBtn" value="${msg("doSubmit")}" />
                        </#if>
                    </form>
            </#if>
        </@layout.registrationLayout>