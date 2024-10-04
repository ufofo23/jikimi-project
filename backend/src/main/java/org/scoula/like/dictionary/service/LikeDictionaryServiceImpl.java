package org.scoula.like.dictionary.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.scoula.dictionary.domain.DictionaryDTO;
import org.scoula.like.dictionary.mapper.LikeDictionaryMapper;
import org.scoula.oauth.jwt.JwtUtil;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class LikeDictionaryServiceImpl implements LikeDictionaryService {

    private final LikeDictionaryMapper mapper;

    private final JwtUtil jwtUtil;

    @Override
    public int create(int dicNo, String token) {
        token = token.substring(7);
        String userId = jwtUtil.getUserIdFromToken(token);
        return mapper.create(dicNo, userId);
    }

    @Override
    public List<DictionaryDTO> getList(String token) {
        token = token.substring(7);
        String userId = jwtUtil.getUserIdFromToken(token);

        return mapper.getList(userId).stream()
                .map(DictionaryDTO::of)
                .toList();
    }
}
