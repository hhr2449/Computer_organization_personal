    # 输出编码范围由 0x21 到 0x7E
    li a0, 0x21
    li t2, 0x7F
    # 接下来要调用 WRITE_SERIAL 函数
    # 调用函数的时候会将返回地址写入 ra，所以要预先保存 ra 中的地址到栈上
    addi sp, sp, -16
    sw ra, 12(sp)

print_loop:
    # 调用 WRITE_SERIAL 函数，打印 a0 对应的字符
    jal ra, WRITE_SERIAL
    # 将 a0 加 1，对应下一个字符
    addi a0, a0, 1
    # 如果 a0 不等于 t2，则继续打印
    bne a0, t2, print_loop

    # 完成打印后需要恢复栈状态和 ra
    lw ra, 12(sp)
    addi sp, sp, 16
    # 返回 kernel
    jr ra

# 打印函数
WRITE_SERIAL:
    # 串口地址是 0x10000000
    li t0, 0x10000000

    # 轮询串口状态（0x10000005）
.TESTW:
    lb t1, 5(t0)
    # 判断是否可写
    andi t1, t1, 0x20
    beq t1, zero, .TESTW

.WSERIAL:
    # 向终端（0x10000000）输出 a0 寄存器中的最低字节
    sb a0, 0(t0)
    # 跳转回 ra 中的地址
    jr ra