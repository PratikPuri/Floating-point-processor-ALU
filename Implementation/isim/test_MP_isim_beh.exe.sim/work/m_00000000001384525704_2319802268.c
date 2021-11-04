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
static const char *ng0 = "I:/xilinx_project/copy/new/Assignment_2_stable2_working_properly - Copy - Copy - Copy/Comparator.v";



static void Always_24_0(char *t0)
{
    char t4[8];
    char t5[8];
    char t9[8];
    char t41[8];
    char t42[8];
    char t45[8];
    char *t1;
    char *t2;
    char *t3;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    char *t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t43;
    char *t44;
    char *t46;
    char *t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    char *t54;
    char *t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t59;
    char *t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    char *t65;

LAB0:    t1 = (t0 + 2528U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(24, ng0);
    t2 = (t0 + 2848);
    *((int *)t2) = 1;
    t3 = (t0 + 2560);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(25, ng0);
    t6 = (t0 + 1048U);
    t7 = *((char **)t6);
    t6 = (t0 + 1208U);
    t8 = *((char **)t6);
    memset(t9, 0, 8);
    t6 = (t7 + 4);
    t10 = (t8 + 4);
    t11 = *((unsigned int *)t7);
    t12 = *((unsigned int *)t8);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t6);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB8;

LAB5:    if (t20 != 0)
        goto LAB7;

LAB6:    *((unsigned int *)t9) = 1;

LAB8:    memset(t5, 0, 8);
    t24 = (t9 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t9);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB9;

LAB10:    if (*((unsigned int *)t24) != 0)
        goto LAB11;

LAB12:    t31 = (t5 + 4);
    t32 = *((unsigned int *)t5);
    t33 = *((unsigned int *)t31);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB13;

LAB14:    t37 = *((unsigned int *)t5);
    t38 = (~(t37));
    t39 = *((unsigned int *)t31);
    t40 = (t38 || t39);
    if (t40 > 0)
        goto LAB15;

LAB16:    if (*((unsigned int *)t31) > 0)
        goto LAB17;

LAB18:    if (*((unsigned int *)t5) > 0)
        goto LAB19;

LAB20:    memcpy(t4, t41, 8);

LAB21:    t59 = (t0 + 1608);
    xsi_vlogvar_assign_value(t59, t4, 0, 0, 32);
    goto LAB2;

LAB7:    t23 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB8;

LAB9:    *((unsigned int *)t5) = 1;
    goto LAB12;

LAB11:    t30 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB12;

LAB13:    t35 = (t0 + 1048U);
    t36 = *((char **)t35);
    goto LAB14;

LAB15:    t35 = (t0 + 1048U);
    t43 = *((char **)t35);
    t35 = (t0 + 1208U);
    t44 = *((char **)t35);
    memset(t45, 0, 8);
    t35 = (t43 + 4);
    if (*((unsigned int *)t35) != 0)
        goto LAB23;

LAB22:    t46 = (t44 + 4);
    if (*((unsigned int *)t46) != 0)
        goto LAB23;

LAB26:    if (*((unsigned int *)t43) < *((unsigned int *)t44))
        goto LAB24;

LAB25:    memset(t42, 0, 8);
    t48 = (t45 + 4);
    t49 = *((unsigned int *)t48);
    t50 = (~(t49));
    t51 = *((unsigned int *)t45);
    t52 = (t51 & t50);
    t53 = (t52 & 1U);
    if (t53 != 0)
        goto LAB27;

LAB28:    if (*((unsigned int *)t48) != 0)
        goto LAB29;

LAB30:    t55 = (t42 + 4);
    t56 = *((unsigned int *)t42);
    t57 = *((unsigned int *)t55);
    t58 = (t56 || t57);
    if (t58 > 0)
        goto LAB31;

LAB32:    t61 = *((unsigned int *)t42);
    t62 = (~(t61));
    t63 = *((unsigned int *)t55);
    t64 = (t62 || t63);
    if (t64 > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t55) > 0)
        goto LAB35;

LAB36:    if (*((unsigned int *)t42) > 0)
        goto LAB37;

LAB38:    memcpy(t41, t65, 8);

LAB39:    goto LAB16;

LAB17:    xsi_vlog_unsigned_bit_combine(t4, 32, t36, 32, t41, 32);
    goto LAB21;

LAB19:    memcpy(t4, t36, 8);
    goto LAB21;

LAB23:    t47 = (t45 + 4);
    *((unsigned int *)t45) = 1;
    *((unsigned int *)t47) = 1;
    goto LAB25;

LAB24:    *((unsigned int *)t45) = 1;
    goto LAB25;

LAB27:    *((unsigned int *)t42) = 1;
    goto LAB30;

LAB29:    t54 = (t42 + 4);
    *((unsigned int *)t42) = 1;
    *((unsigned int *)t54) = 1;
    goto LAB30;

LAB31:    t59 = (t0 + 1208U);
    t60 = *((char **)t59);
    goto LAB32;

LAB33:    t59 = (t0 + 1048U);
    t65 = *((char **)t59);
    goto LAB34;

LAB35:    xsi_vlog_unsigned_bit_combine(t41, 32, t60, 32, t65, 32);
    goto LAB39;

LAB37:    memcpy(t41, t60, 8);
    goto LAB39;

}


extern void work_m_00000000001384525704_2319802268_init()
{
	static char *pe[] = {(void *)Always_24_0};
	xsi_register_didat("work_m_00000000001384525704_2319802268", "isim/test_MP_isim_beh.exe.sim/work/m_00000000001384525704_2319802268.didat");
	xsi_register_executes(pe);
}
