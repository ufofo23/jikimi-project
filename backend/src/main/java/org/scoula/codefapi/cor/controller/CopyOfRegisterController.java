package org.scoula.codefapi.cor.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.scoula.codefapi.cor.service.CopyOfRegisterService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

@RestController
@RequiredArgsConstructor
public class CopyOfRegisterController {

    private final CopyOfRegisterService copyOfRegisterService;

    @GetMapping("/api/copy-of-register")
    public String copyOfRegister() throws UnsupportedEncodingException, JsonProcessingException, InterruptedException, NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeySpecException, BadPaddingException, InvalidKeyException {
        copyOfRegisterService.getCopyOfRegister();
        return "";
    }

}
