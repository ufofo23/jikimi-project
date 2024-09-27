package org.scoula.map.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.map.domain.AddressVO;
import org.scoula.map.mapper.AddressMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@RequiredArgsConstructor
public class AddressServiceImpl implements AddressService {

    final private AddressMapper mapper;

    @Override
    public List<AddressVO> getAllAddress() {
        log.info("getAddressList*********************************");
        return mapper.getAdressList().stream().toList();
    }
}