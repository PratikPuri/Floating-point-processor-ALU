/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "I:/xilinx_project/copy/new/Assignment_2_stable2_working_properly - Copy - Copy - Copy/aluWB.v";



static void Always_30_0(char *t0)
{
    char t4[8];
    char t5[8];
    char t18[8];
    char t34[8];
    char t35[8];
    char t48[8];
    char *t1;
    char *t2;
    char *t3;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t36;
    char *t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    char *t43;
    char *t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    char *t49;
    char *t50;
    char *t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    char *t62;
    char *t63;

LAB0:    t1 = (t0 + 4448U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 5016);
    *((int *)t2) = 1;
    t3 = (t0 + 4480);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(31, ng0);

LAB5:    xsi_set_current_line(33, ng0);
    t6 = (t0 + 2168U);
    t7 = *((char **)t6);
    memset(t5, 0, 8);
    t6 = (t7 + 4);
    t8 = *((unsigned int *)t6);
    t9 = (~(t8));
    t10 = *((unsigned int *)t7);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB6;

LAB7:    if (*((unsigned int *)t6) != 0)
        goto LAB8;

LAB9:    t14 = (t5 + 4);
    t15 = *((unsigned int *)t5);
    t16 = *((unsigned int *)t14);
    t17 = (t15 || t16);
    if (t17 > 0)
        goto LAB10;

LAB11:    t30 = *((unsigned int *)t5);
    t31 = (~(t30));
    t32 = *((unsigned int *)t14);
    t33 = (t31 || t32);
    if (t33 > 0)
        goto LAB12;

LAB13:    if (*((unsigned int *)t14) > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t5) > 0)
        goto LAB16;

LAB17:    memcpy(t4, t34, 8);

LAB18:    t62 = (t0 + 3208);
    xsi_vlogvar_assign_value(t62, t4, 0, 0, 32);
    xsi_set_current_line(35, ng0);
    t2 = (t0 + 2328U);
    t3 = *((char **)t2);
    memset(t5, 0, 8);
    t2 = (t3 + 4);
    t8 = *((unsigned int *)t2);
    t9 = (~(t8));
    t10 = *((unsigned int *)t3);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB32;

LAB33:    if (*((unsigned int *)t2) != 0)
        goto LAB34;

LAB35:    t7 = (t5 + 4);
    t15 = *((unsigned int *)t5);
    t16 = *((unsigned int *)t7);
    t17 = (t15 || t16);
    if (t17 > 0)
        goto LAB36;

LAB37:    t30 = *((unsigned int *)t5);
    t31 = (~(t30));
    t32 = *((unsigned int *)t7);
    t33 = (t31 || t32);
    if (t33 > 0)
        goto LAB38;

LAB39:    if (*((unsigned int *)t7) > 0)
        goto LAB40;

LAB41:    if (*((unsigned int *)t5) > 0)
        goto LAB42;

LAB43:    memcpy(t4, t34, 8);

LAB44:    t50 = (t0 + 3368);
    xsi_vlogvar_assign_value(t50, t4, 0, 0, 32);
    goto LAB2;

LAB6:    *((unsigned int *)t5) = 1;
    goto LAB9;

LAB8:    t13 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t13) = 1;
    goto LAB9;

LAB10:    t19 = (t0 + 3528);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memset(t18, 0, 8);
    t22 = (t18 + 4);
    t23 = (t21 + 4);
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t18) = t25;
    t26 = *((unsigned int *)t23);
    t27 = (t26 >> 0);
    *((unsigned int *)t22) = t27;
    t28 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t28 & 4294967295U);
    t29 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t29 & 4294967295U);
    goto LAB11;

LAB12:    t36 = (t0 + 1688U);
    t37 = *((char **)t36);
    memset(t35, 0, 8);
    t36 = (t37 + 4);
    t38 = *((unsigned int *)t36);
    t39 = (~(t38));
    t40 = *((unsigned int *)t37);
    t41 = (t40 & t39);
    t42 = (t41 & 1U);
    if (t42 != 0)
        goto LAB19;

LAB20:    if (*((unsigned int *)t36) != 0)
        goto LAB21;

LAB22:    t44 = (t35 + 4);
    t45 = *((unsigned int *)t35);
    t46 = *((unsigned int *)t44);
    t47 = (t45 || t46);
    if (t47 > 0)
        goto LAB23;

LAB24:    t58 = *((unsigned int *)t35);
    t59 = (~(t58));
    t60 = *((unsigned int *)t44);
    t61 = (t59 || t60);
    if (t61 > 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t44) > 0)
        goto LAB27;

LAB28:    if (*((unsigned int *)t35) > 0)
        goto LAB29;

LAB30:    memcpy(t34, t63, 8);

LAB31:    goto LAB13;

LAB14:    xsi_vlog_unsigned_bit_combine(t4, 32, t18, 32, t34, 32);
    goto LAB18;

LAB16:    memcpy(t4, t18, 8);
    goto LAB18;

LAB19:    *((unsigned int *)t35) = 1;
    goto LAB22;

LAB21:    t43 = (t35 + 4);
    *((unsigned int *)t35) = 1;
    *((unsigned int *)t43) = 1;
    goto LAB22;

LAB23:    t49 = (t0 + 1528U);
    t50 = *((char **)t49);
    memset(t48, 0, 8);
    t49 = (t48 + 4);
    t51 = (t50 + 4);
    t52 = *((unsigned int *)t50);
    t53 = (t52 >> 0);
    *((unsigned int *)t48) = t53;
    t54 = *((unsigned int *)t51);
    t55 = (t54 >> 0);
    *((unsigned int *)t49) = t55;
    t56 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t56 & 4294967295U);
    t57 = *((unsigned int *)t49);
    *((unsigned int *)t49) = (t57 & 4294967295U);
    goto LAB24;

LAB25:    t62 = (t0 + 1208U);
    t63 = *((char **)t62);
    goto LAB26;

LAB27:    xsi_vlog_unsigned_bit_combine(t34, 32, t48, 32, t63, 32);
    goto LAB31;

LAB29:    memcpy(t34, t48, 8);
    goto LAB31;

LAB32:    *((unsigned int *)t5) = 1;
    goto LAB35;

LAB34:    t6 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t6) = 1;
    goto LAB35;

LAB36:    t13 = (t0 + 3528);
    t14 = (t13 + 56U);
    t19 = *((char **)t14);
    memset(t18, 0, 8);
    t20 = (t18 + 4);
    t21 = (t19 + 4);
    t24 = *((unsigned int *)t19);
    t25 = (t24 >> 0);
    *((unsigned int *)t18) = t25;
    t26 = *((unsigned int *)t21);
    t27 = (t26 >> 0);
    *((unsigned int *)t20) = t27;
    t28 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t28 & 4294967295U);
    t29 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t29 & 4294967295U);
    goto LAB37;

LAB38:    t22 = (t0 + 2008U);
    t23 = *((char **)t22);
    memset(t35, 0, 8);
    t22 = (t23 + 4);
    t38 = *((unsigned int *)t22);
    t39 = (~(t38));
    t40 = *((unsigned int *)t23);
    t41 = (t40 & t39);
    t42 = (t41 & 1U);
    if (t42 != 0)
        goto LAB45;

LAB46:    if (*((unsigned int *)t22) != 0)
        goto LAB47;

LAB48:    t37 = (t35 + 4);
    t45 = *((unsigned int *)t35);
    t46 = *((unsigned int *)t37);
    t47 = (t45 || t46);
    if (t47 > 0)
        goto LAB49;

LAB50:    t58 = *((unsigned int *)t35);
    t59 = (~(t58));
    t60 = *((unsigned int *)t37);
    t61 = (t59 || t60);
    if (t61 > 0)
        goto LAB51;

LAB52:    if (*((unsigned int *)t37) > 0)
        goto LAB53;

LAB54:    if (*((unsigned int *)t35) > 0)
        goto LAB55;

LAB56:    memcpy(t34, t51, 8);

LAB57:    goto LAB39;

LAB40:    xsi_vlog_unsigned_bit_combine(t4, 32, t18, 32, t34, 32);
    goto LAB44;

LAB42:    memcpy(t4, t18, 8);
    goto LAB44;

LAB45:    *((unsigned int *)t35) = 1;
    goto LAB48;

LAB47:    t36 = (t35 + 4);
    *((unsigned int *)t35) = 1;
    *((unsigned int *)t36) = 1;
    goto LAB48;

LAB49:    t43 = (t0 + 1528U);
    t44 = *((char **)t43);
    memset(t48, 0, 8);
    t43 = (t48 + 4);
    t49 = (t44 + 4);
    t52 = *((unsigned int *)t44);
    t53 = (t52 >> 0);
    *((unsigned int *)t48) = t53;
    t54 = *((unsigned int *)t49);
    t55 = (t54 >> 0);
    *((unsigned int *)t43) = t55;
    t56 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t56 & 4294967295U);
    t57 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t57 & 4294967295U);
    goto LAB50;

LAB51:    t50 = (t0 + 1368U);
    t51 = *((char **)t50);
    goto LAB52;

LAB53:    xsi_vlog_unsigned_bit_combine(t34, 32, t48, 32, t51, 32);
    goto LAB57;

LAB55:    memcpy(t34, t48, 8);
    goto LAB57;

}

static void Always_38_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 4696U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 5032);
    *((int *)t2) = 1;
    t3 = (t0 + 4728);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(39, ng0);

LAB5:    xsi_set_current_line(40, ng0);
    t4 = (t0 + 1528U);
    t5 = *((char **)t4);
    t4 = (t0 + 3528);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, 0, 64, 0LL);
    goto LAB2;

}


extern void work_m_00000000000066603944_0575723682_init()
{
	static char *pe[] = {(void *)Always_30_0,(void *)Always_38_1};
	xsi_register_didat("work_m_00000000000066603944_0575723682", "isim/test_MP_isim_beh.exe.sim/work/m_00000000000066603944_0575723682.didat");
	xsi_register_executes(pe);
}
