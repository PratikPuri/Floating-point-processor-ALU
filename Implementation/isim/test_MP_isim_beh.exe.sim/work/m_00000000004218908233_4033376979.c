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
static const char *ng0 = "I:/xilinx_project/copy/new/Assignment_2_stable2_working_properly - Copy - Copy - Copy/Adder.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {2, 0};
static int ng4[] = {3, 0};
static int ng5[] = {2, 0, 0, 0};
static int ng6[] = {1, 0, 0, 0};



static void Always_28_0(char *t0)
{
    char t4[8];
    char t7[8];
    char t17[8];
    char t30[16];
    char t34[16];
    char t35[16];
    char t40[16];
    char t41[16];
    char t42[16];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    int t26;
    char *t27;
    char *t28;
    char *t29;
    char *t31;
    int t32;
    int t33;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;

LAB0:    t1 = (t0 + 2848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 3168);
    *((int *)t2) = 1;
    t3 = (t0 + 2880);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(29, ng0);

LAB5:    xsi_set_current_line(30, ng0);
    t5 = (t0 + 1208U);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    t5 = (t7 + 4);
    t8 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 31);
    t11 = (t10 & 1);
    *((unsigned int *)t7) = t11;
    t12 = *((unsigned int *)t8);
    t13 = (t12 >> 31);
    t14 = (t13 & 1);
    *((unsigned int *)t5) = t14;
    t15 = (t0 + 1048U);
    t16 = *((char **)t15);
    memset(t17, 0, 8);
    t15 = (t17 + 4);
    t18 = (t16 + 4);
    t19 = *((unsigned int *)t16);
    t20 = (t19 >> 31);
    t21 = (t20 & 1);
    *((unsigned int *)t17) = t21;
    t22 = *((unsigned int *)t18);
    t23 = (t22 >> 31);
    t24 = (t23 & 1);
    *((unsigned int *)t15) = t24;
    xsi_vlogtype_concat(t4, 32, 2, 2U, t17, 1, t7, 1);

LAB6:    t25 = ((char*)((ng1)));
    t26 = xsi_vlog_unsigned_case_compare(t4, 32, t25, 32);
    if (t26 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng2)));
    t26 = xsi_vlog_unsigned_case_compare(t4, 32, t2, 32);
    if (t26 == 1)
        goto LAB9;

LAB10:    t3 = ((char*)((ng3)));
    t32 = xsi_vlog_unsigned_case_compare(t4, 32, t3, 32);
    if (t32 == 1)
        goto LAB11;

LAB12:    t5 = ((char*)((ng4)));
    t33 = xsi_vlog_unsigned_case_compare(t4, 32, t5, 32);
    if (t33 == 1)
        goto LAB13;

LAB14:
LAB15:    goto LAB2;

LAB7:    xsi_set_current_line(31, ng0);
    t27 = (t0 + 1048U);
    t28 = *((char **)t27);
    t27 = (t0 + 1208U);
    t29 = *((char **)t27);
    xsi_vlog_unsigned_add(t30, 33, t28, 32, t29, 32);
    t27 = (t0 + 1608);
    xsi_vlogvar_assign_value(t27, t30, 0, 0, 32);
    t31 = (t0 + 1768);
    xsi_vlogvar_assign_value(t31, t30, 32, 0, 1);
    goto LAB15;

LAB9:    goto LAB7;

LAB11:    goto LAB7;

LAB13:    xsi_set_current_line(32, ng0);
    t6 = (t0 + 1048U);
    t8 = *((char **)t6);
    memset(t7, 0, 8);
    t6 = (t7 + 4);
    t15 = (t8 + 4);
    t9 = *((unsigned int *)t8);
    t10 = (~(t9));
    *((unsigned int *)t7) = t10;
    *((unsigned int *)t6) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB17;

LAB16:    t19 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t19 & 4294967295U);
    t20 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t20 & 4294967295U);
    xsi_vlogtype_concat(t34, 33, 32, 1U, t7, 32);
    t16 = (t0 + 1208U);
    t18 = *((char **)t16);
    memset(t17, 0, 8);
    t16 = (t17 + 4);
    t25 = (t18 + 4);
    t21 = *((unsigned int *)t18);
    t22 = (~(t21));
    *((unsigned int *)t17) = t22;
    *((unsigned int *)t16) = 0;
    if (*((unsigned int *)t25) != 0)
        goto LAB19;

LAB18:    t38 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t38 & 4294967295U);
    t39 = *((unsigned int *)t16);
    *((unsigned int *)t16) = (t39 & 4294967295U);
    xsi_vlogtype_concat(t35, 33, 32, 1U, t17, 32);
    xsi_vlog_unsigned_add(t40, 33, t34, 33, t35, 33);
    t27 = ((char*)((ng5)));
    xsi_vlog_unsigned_add(t41, 33, t40, 33, t27, 32);
    xsi_vlogtype_unsigned_bit_neg(t30, 33, t41, 33);
    t28 = ((char*)((ng6)));
    xsi_vlog_unsigned_add(t42, 33, t30, 33, t28, 32);
    t29 = (t0 + 1608);
    xsi_vlogvar_assign_value(t29, t42, 0, 0, 32);
    t31 = (t0 + 1768);
    xsi_vlogvar_assign_value(t31, t42, 32, 0, 1);
    goto LAB15;

LAB17:    t11 = *((unsigned int *)t7);
    t12 = *((unsigned int *)t15);
    *((unsigned int *)t7) = (t11 | t12);
    t13 = *((unsigned int *)t6);
    t14 = *((unsigned int *)t15);
    *((unsigned int *)t6) = (t13 | t14);
    goto LAB16;

LAB19:    t23 = *((unsigned int *)t17);
    t24 = *((unsigned int *)t25);
    *((unsigned int *)t17) = (t23 | t24);
    t36 = *((unsigned int *)t16);
    t37 = *((unsigned int *)t25);
    *((unsigned int *)t16) = (t36 | t37);
    goto LAB18;

}


extern void work_m_00000000004218908233_4033376979_init()
{
	static char *pe[] = {(void *)Always_28_0};
	xsi_register_didat("work_m_00000000004218908233_4033376979", "isim/test_MP_isim_beh.exe.sim/work/m_00000000004218908233_4033376979.didat");
	xsi_register_executes(pe);
}
