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
static const char *ng0 = "I:/xilinx_project/copy/new/Assignment_2_stable2_working_properly - Copy - Copy - Copy/Multiplication.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {1, 0, 0, 0};
static int ng4[] = {2, 0};
static int ng5[] = {3, 0};
static int ng6[] = {0, 0, 0, 0};



static void Always_25_0(char *t0)
{
    char t4[8];
    char t7[8];
    char t17[8];
    char t30[16];
    char t31[16];
    char t32[16];
    char t33[16];
    char t34[16];
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
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;

LAB0:    t1 = (t0 + 2528U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 2848);
    *((int *)t2) = 1;
    t3 = (t0 + 2560);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(26, ng0);

LAB5:    xsi_set_current_line(27, ng0);
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

LAB10:    t2 = ((char*)((ng4)));
    t26 = xsi_vlog_unsigned_case_compare(t4, 32, t2, 32);
    if (t26 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng5)));
    t26 = xsi_vlog_unsigned_case_compare(t4, 32, t2, 32);
    if (t26 == 1)
        goto LAB13;

LAB14:
LAB16:
LAB15:    xsi_set_current_line(32, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 64);

LAB17:    goto LAB2;

LAB7:    xsi_set_current_line(28, ng0);
    t27 = (t0 + 1048U);
    t28 = *((char **)t27);
    t27 = (t0 + 1208U);
    t29 = *((char **)t27);
    xsi_vlog_unsigned_multiply(t30, 64, t28, 32, t29, 32);
    t27 = (t0 + 1608);
    xsi_vlogvar_assign_value(t27, t30, 0, 0, 64);
    goto LAB17;

LAB9:    xsi_set_current_line(29, ng0);
    t3 = (t0 + 1048U);
    t5 = *((char **)t3);
    t3 = (t0 + 1208U);
    t6 = *((char **)t3);
    memset(t7, 0, 8);
    t3 = (t7 + 4);
    t8 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (~(t9));
    *((unsigned int *)t7) = t10;
    *((unsigned int *)t3) = 0;
    if (*((unsigned int *)t8) != 0)
        goto LAB19;

LAB18:    t19 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t19 & 4294967295U);
    t20 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t20 & 4294967295U);
    xsi_vlogtype_concat(t31, 64, 32, 1U, t7, 32);
    t15 = ((char*)((ng3)));
    xsi_vlog_unsigned_add(t32, 64, t31, 64, t15, 32);
    xsi_vlog_unsigned_multiply(t33, 64, t5, 32, t32, 64);
    xsi_vlogtype_unsigned_bit_neg(t30, 64, t33, 64);
    t16 = ((char*)((ng3)));
    xsi_vlog_unsigned_add(t34, 64, t30, 64, t16, 32);
    t18 = (t0 + 1608);
    xsi_vlogvar_assign_value(t18, t34, 0, 0, 64);
    goto LAB17;

LAB11:    xsi_set_current_line(30, ng0);
    t3 = (t0 + 1048U);
    t5 = *((char **)t3);
    memset(t7, 0, 8);
    t3 = (t7 + 4);
    t6 = (t5 + 4);
    t9 = *((unsigned int *)t5);
    t10 = (~(t9));
    *((unsigned int *)t7) = t10;
    *((unsigned int *)t3) = 0;
    if (*((unsigned int *)t6) != 0)
        goto LAB21;

LAB20:    t19 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t19 & 4294967295U);
    t20 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t20 & 4294967295U);
    xsi_vlogtype_concat(t31, 64, 32, 1U, t7, 32);
    t8 = ((char*)((ng3)));
    xsi_vlog_unsigned_add(t32, 64, t31, 64, t8, 32);
    t15 = (t0 + 1208U);
    t16 = *((char **)t15);
    xsi_vlog_unsigned_multiply(t33, 64, t32, 64, t16, 32);
    xsi_vlogtype_unsigned_bit_neg(t30, 64, t33, 64);
    t15 = ((char*)((ng3)));
    xsi_vlog_unsigned_add(t34, 64, t30, 64, t15, 32);
    t18 = (t0 + 1608);
    xsi_vlogvar_assign_value(t18, t34, 0, 0, 64);
    goto LAB17;

LAB13:    xsi_set_current_line(31, ng0);
    t3 = (t0 + 1048U);
    t5 = *((char **)t3);
    memset(t7, 0, 8);
    t3 = (t7 + 4);
    t6 = (t5 + 4);
    t9 = *((unsigned int *)t5);
    t10 = (~(t9));
    *((unsigned int *)t7) = t10;
    *((unsigned int *)t3) = 0;
    if (*((unsigned int *)t6) != 0)
        goto LAB23;

LAB22:    t19 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t19 & 4294967295U);
    t20 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t20 & 4294967295U);
    xsi_vlogtype_concat(t30, 64, 32, 1U, t7, 32);
    t8 = ((char*)((ng3)));
    xsi_vlog_unsigned_add(t31, 64, t30, 64, t8, 32);
    t15 = (t0 + 1208U);
    t16 = *((char **)t15);
    memset(t17, 0, 8);
    t15 = (t17 + 4);
    t18 = (t16 + 4);
    t21 = *((unsigned int *)t16);
    t22 = (~(t21));
    *((unsigned int *)t17) = t22;
    *((unsigned int *)t15) = 0;
    if (*((unsigned int *)t18) != 0)
        goto LAB25;

LAB24:    t37 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t37 & 4294967295U);
    t38 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t38 & 4294967295U);
    xsi_vlogtype_concat(t32, 64, 32, 1U, t17, 32);
    t25 = ((char*)((ng3)));
    xsi_vlog_unsigned_add(t33, 64, t32, 64, t25, 32);
    xsi_vlog_unsigned_multiply(t34, 64, t31, 64, t33, 64);
    t27 = (t0 + 1608);
    xsi_vlogvar_assign_value(t27, t34, 0, 0, 64);
    goto LAB17;

LAB19:    t11 = *((unsigned int *)t7);
    t12 = *((unsigned int *)t8);
    *((unsigned int *)t7) = (t11 | t12);
    t13 = *((unsigned int *)t3);
    t14 = *((unsigned int *)t8);
    *((unsigned int *)t3) = (t13 | t14);
    goto LAB18;

LAB21:    t11 = *((unsigned int *)t7);
    t12 = *((unsigned int *)t6);
    *((unsigned int *)t7) = (t11 | t12);
    t13 = *((unsigned int *)t3);
    t14 = *((unsigned int *)t6);
    *((unsigned int *)t3) = (t13 | t14);
    goto LAB20;

LAB23:    t11 = *((unsigned int *)t7);
    t12 = *((unsigned int *)t6);
    *((unsigned int *)t7) = (t11 | t12);
    t13 = *((unsigned int *)t3);
    t14 = *((unsigned int *)t6);
    *((unsigned int *)t3) = (t13 | t14);
    goto LAB22;

LAB25:    t23 = *((unsigned int *)t17);
    t24 = *((unsigned int *)t18);
    *((unsigned int *)t17) = (t23 | t24);
    t35 = *((unsigned int *)t15);
    t36 = *((unsigned int *)t18);
    *((unsigned int *)t15) = (t35 | t36);
    goto LAB24;

}


extern void work_m_00000000003819185223_2090701490_init()
{
	static char *pe[] = {(void *)Always_25_0};
	xsi_register_didat("work_m_00000000003819185223_2090701490", "isim/test_MP_isim_beh.exe.sim/work/m_00000000003819185223_2090701490.didat");
	xsi_register_executes(pe);
}
