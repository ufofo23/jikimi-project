package org.scoula.map.mapper;

import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;

import java.util.List;

public interface MapMapper {
    public List<MapVO> getAddressList();

    public List<MapDetailDTO> getAddressDetails(Long id);

}
