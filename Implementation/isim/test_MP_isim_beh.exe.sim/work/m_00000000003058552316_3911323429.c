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
static const char *ng0 = "I:/xilinx_project/copy/new/Assignment_2_stable2_working_properly - Copy - Copy - Copy/InstructMem.v";
static const char *ng1 = "ins.tv";
static int ng2[] = {0, 0};
static int ng3[] = {2, 0};
static int ng4[] = {16, 0};
static int ng5[] = {1, 0};



static void Initial_28_0(char *t0)
{
    char *t1;

LAB0:    xsi_set_current_line(29, ng0);

LAB2:    xsi_set_current_line(30, ng0);
    t1 = (t0 + 2248);
    xsi_vlogfile_readmemb(ng1, 0, t1, 0, 0, 0, 0);

LAB1:    return;
}

static void Always_34_1(char *t0)
{
    char t13[8];
    char t14[8];
    char t35[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    unsigned int t25;
    int t26;
    char *t27;
    unsigned int t28;
    int t29;
    int t30;
    unsigned int t31;
    unsigned int t32;
    int t33;
    int t34;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;

LAB0:    t1 = (t0 + 3896U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 4216);
    *((int *)t2) = 1;
    t3 = (t0 + 3928);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(35, ng0);

LAB5:    xsi_set_current_line(37, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(45, ng0);

LAB10:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB11;

LAB12:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 16, 0LL);

LAB13:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB15;

LAB16:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 2248);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t15 = (t0 + 2248);
    t16 = (t15 + 64U);
    t17 = *((char **)t16);
    t18 = (t0 + 2408);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    xsi_vlog_generic_get_array_select_value(t13, 16, t4, t12, t17, 2, 1, t20, 4, 2);
    t21 = (t0 + 2248);
    t22 = (t0 + 2248);
    t23 = (t22 + 72U);
    t24 = *((char **)t23);
    t27 = (t0 + 2248);
    t36 = (t27 + 64U);
    t37 = *((char **)t36);
    t38 = (t0 + 2408);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    xsi_vlog_generic_convert_array_indices(t14, t35, t24, t37, 2, 1, t40, 4, 2);
    t41 = (t14 + 4);
    t6 = *((unsigned int *)t41);
    t26 = (!(t6));
    t42 = (t35 + 4);
    t7 = *((unsigned int *)t42);
    t29 = (!(t7));
    t30 = (t26 && t29);
    if (t30 == 1)
        goto LAB20;

LAB21:
LAB17:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 1688U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB22;

LAB23:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 4, 0LL);

LAB24:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(38, ng0);

LAB9:    xsi_set_current_line(39, ng0);
    t11 = ((char*)((ng2)));
    t12 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 4, 0LL);
    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng3)));
    t3 = ((char*)((ng4)));
    memset(t13, 0, 8);
    xsi_vlog_signed_power(t13, 32, t2, 32, t3, 32, 1);
    t4 = ((char*)((ng5)));
    memset(t14, 0, 8);
    xsi_vlog_signed_minus(t14, 32, t13, 32, t4, 32);
    t5 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t5, t14, 0, 0, 16, 0LL);
    goto LAB8;

LAB11:    xsi_set_current_line(47, ng0);

LAB14:    xsi_set_current_line(48, ng0);
    t4 = (t0 + 2248);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t12 + 72U);
    t16 = *((char **)t15);
    t17 = (t0 + 2248);
    t18 = (t17 + 64U);
    t19 = *((char **)t18);
    t20 = (t0 + 2408);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    xsi_vlog_generic_get_array_select_value(t13, 16, t11, t16, t19, 2, 1, t22, 4, 2);
    t23 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t23, t13, 0, 0, 16, 0LL);
    goto LAB13;

LAB15:    xsi_set_current_line(53, ng0);
    t4 = (t0 + 2088);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    t12 = (t0 + 2248);
    t15 = (t0 + 2248);
    t16 = (t15 + 72U);
    t17 = *((char **)t16);
    t18 = (t0 + 2248);
    t19 = (t18 + 64U);
    t20 = *((char **)t19);
    t21 = (t0 + 2408);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    xsi_vlog_generic_convert_array_indices(t13, t14, t17, t20, 2, 1, t23, 4, 2);
    t24 = (t13 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (!(t25));
    t27 = (t14 + 4);
    t28 = *((unsigned int *)t27);
    t29 = (!(t28));
    t30 = (t26 && t29);
    if (t30 == 1)
        goto LAB18;

LAB19:    goto LAB17;

LAB18:    t31 = *((unsigned int *)t13);
    t32 = *((unsigned int *)t14);
    t33 = (t31 - t32);
    t34 = (t33 + 1);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, *((unsigned int *)t14), t34, 0LL);
    goto LAB19;

LAB20:    t8 = *((unsigned int *)t14);
    t9 = *((unsigned int *)t35);
    t33 = (t8 - t9);
    t34 = (t33 + 1);
    xsi_vlogvar_wait_assign_value(t21, t13, 0, *((unsigned int *)t35), t34, 0LL);
    goto LAB21;

LAB22:    xsi_set_current_line(57, ng0);
    t4 = (t0 + 2408);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    t12 = ((char*)((ng5)));
    memset(t13, 0, 8);
    xsi_vlog_unsigned_add(t13, 32, t11, 4, t12, 32);
    t15 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t15, t13, 0, 0, 4, 0LL);
    t16 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t16, t13, 4, 0, 1, 0LL);
    goto LAB24;

}


extern void work_m_00000000003058552316_3911323429_init()
{
	static char *pe[] = {(void *)Initial_28_0,(void *)Always_34_1};
	xsi_register_didat("work_m_00000000003058552316_3911323429", "isim/test_MP_isim_beh.exe.sim/work/m_00000000003058552316_3911323429.didat");
	xsi_register_executes(pe);
}
