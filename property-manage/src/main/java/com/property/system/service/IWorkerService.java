package com.property.system.service;

import com.property.system.domain.Worker;
import java.util.List;

public interface IWorkerService {
    /**
     * 查询工人信息
     */
    Worker selectWorkerById(Long workerId);

    /**
     * 查询工人信息列表
     */
    List<Worker> selectWorkerList(Worker worker);

    /**
     * 新增工人信息
     */
    int insertWorker(Worker worker);

    /**
     * 修改工人信息
     */
    int updateWorker(Worker worker);

    /**
     * 批量删除工人信息
     */
    int deleteWorkerByIds(Long[] workerIds);

    /**
     * 根据用户ID查询工人信息
     * @param userId 用户ID
     * @return 工人信息
     */
    Worker selectWorkerByUserId(Long userId);
}