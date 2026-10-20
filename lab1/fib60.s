    # 执行 58 次循环
    li a0, 58
    # t0 保存旧值低位，t1 保存旧值高位
    li t0, 1
    li t1, 0
    # t2 保存新值低位，t3 保存新值高位
    li t2, 1
    li t3, 0
    # t4 保存刚刚算出来的值的低位，t5 保存高位
.L1:
    # 计算 fib(i)
    # 先进行低位相加
    add t4, t0, t2
    # 判断是否由进位，如果有进位，则t4 < t6，此时 t6 = 1
    sltu t6, t4, t0
    # 进行高位相加
    add t5, t1, t3
    # 再加上进位
    add t5, t5, t6
    # 保存结果
    addi t0, t2, 0
    addi t1, t3, 0
    addi t2, t4, 0
    addi t3, t5, 0
    # 剩余次数减一
    addi a0, a0, -1
    bne zero, a0, .L1
    # 循环结束，将结果保存到指定内存地址
    # 采用小端序
    li a1, 0x80400000
    sw t4, 0(a1)
    sw t5, 4(a1)

    jr ra

