package com.property.system.service.impl;

import com.property.common.core.text.Convert;
import com.property.system.domain.Worker;
import com.property.system.mapper.WorkerMapper;
import com.property.system.service.IWorkerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WorkerServiceImpl implements IWorkerService {
    @Autowired
    private WorkerMapper workerMapper;

    /**
     * 查询工人信息
     */
    @Override
    public Worker selectWorkerById(Long workerId) {
        return workerMapper.selectWorkerById(workerId);
    }

    /**
     * 查询工人信息列表
     */
    @Override
    public List<Worker> selectWorkerList(Worker worker) {
        return workerMapper.selectWorkerList(worker);
    }

    /**
     * 新增工人信息
     */
    @Override
    public int insertWorker(Worker worker) {
        return workerMapper.insertWorker(worker);
    }

    /**
     * 修改工人信息
     */
    @Override
    public int updateWorker(Worker worker) {
        return workerMapper.updateWorker(worker);
    }

    /**
     * 批量删除工人信息
     */
    @Override
    public int deleteWorkerByIds(Long[] workerIds) {
        return workerMapper.deleteWorkerByIds(workerIds);
    }

    /**
     * 根据用户ID查询工人信息
     *
     * @param userId 用户ID
     * @return 工人信息
     */
    @Override
    public Worker selectWorkerByUserId(Long userId) {
        return workerMapper.selectWorkerByUserId(userId);
    }
}