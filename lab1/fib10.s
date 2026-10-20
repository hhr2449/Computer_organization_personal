    # t0 中保存当前结果存储地址
    li t0, 0x80400000
    # t1 中保存较旧的结果，t2 保存较新的结果，t3 保存刚刚算出来的结果，t4保存剩余循环次数
    li t1, 1
    li t2, 1
    li t4, 8
    sw t1, 0(t0)
    sw t2, 4(t0)
    addi t0, t0, 8
.L1:
    # 计算结果
    add t3, t1, t2
    # 存储结果
    sw t3, 0(t0)
    addi t0, t0, 4
    # 更新寄存器
    addi t1, t2, 0
    addi t2, t3, 0
    # 循环次数减一
    addi t4, t4, -1
    # 判断是否跳转
    bne zero, t4, .L1
    jr ra
