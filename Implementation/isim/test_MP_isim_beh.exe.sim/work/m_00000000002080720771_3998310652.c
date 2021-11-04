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
static const char *ng0 = "I:/xilinx_project/copy/new/Assignment_2_stable2_working_properly - Copy - Copy - Copy/RegStack0_15.v";
static const char *ng1 = "reg.tv";
static int ng2[] = {1, 0};
static int ng3[] = {0, 0};



static void Initial_30_0(char *t0)
{
    char *t1;

LAB0:    xsi_set_current_line(30, ng0);

LAB2:    xsi_set_current_line(31, ng0);
    t1 = (t0 + 3368);
    xsi_vlogfile_readmemb(ng1, 0, t1, 0, 0, 0, 0);

LAB1:    return;
}

static void Cont_36_1(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 5336U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 2168U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t4, 0, 8);
    xsi_vlog_unsigned_add(t4, 32, t3, 4, t2, 32);
    t5 = (t0 + 6000);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 15U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 3);
    t18 = (t0 + 5904);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_38_2(char *t0)
{
    char t13[8];
    char t21[8];
    char t31[8];
    char t33[8];
    char t40[8];
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
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned int t22;
    int t23;
    unsigned int t24;
    int t25;
    int t26;
    unsigned int t27;
    unsigned int t28;
    int t29;
    int t30;
    char *t32;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t41;
    char *t42;

LAB0:    t1 = (t0 + 5584U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 5920);
    *((int *)t2) = 1;
    t3 = (t0 + 5616);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(39, ng0);

LAB5:    xsi_set_current_line(40, ng0);
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

LAB7:    xsi_set_current_line(49, ng0);

LAB10:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB11;

LAB12:    xsi_set_current_line(56, ng0);

LAB15:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 3048);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3048);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 32, 0LL);
    xsi_set_current_line(58, ng0);
    t2 = (t0 + 3208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3208);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 32, 0LL);

LAB13:    xsi_set_current_line(60, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB16;

LAB17:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3368);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t14 = (t0 + 3368);
    t15 = (t14 + 64U);
    t16 = *((char **)t15);
    t17 = (t0 + 2168U);
    t18 = *((char **)t17);
    xsi_vlog_generic_get_array_select_value(t13, 32, t4, t12, t16, 2, 1, t18, 4, 2);
    t17 = (t0 + 3368);
    t19 = (t0 + 3368);
    t20 = (t19 + 72U);
    t32 = *((char **)t20);
    t34 = (t0 + 3368);
    t35 = (t34 + 64U);
    t36 = *((char **)t35);
    t37 = (t0 + 2168U);
    t38 = *((char **)t37);
    xsi_vlog_generic_convert_array_indices(t21, t31, t32, t36, 2, 1, t38, 4, 2);
    t37 = (t21 + 4);
    t6 = *((unsigned int *)t37);
    t23 = (!(t6));
    t39 = (t31 + 4);
    t7 = *((unsigned int *)t39);
    t25 = (!(t7));
    t26 = (t23 && t25);
    if (t26 == 1)
        goto LAB29;

LAB30:
LAB18:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(41, ng0);

LAB9:    xsi_set_current_line(42, ng0);
    t11 = ((char*)((ng3)));
    t12 = (t0 + 3048);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 32, 0LL);
    xsi_set_current_line(43, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3208);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(44, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3688);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    xsi_set_current_line(45, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3848);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    goto LAB8;

LAB11:    xsi_set_current_line(51, ng0);

LAB14:    xsi_set_current_line(52, ng0);
    t4 = (t0 + 3368);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    t12 = (t0 + 3368);
    t14 = (t12 + 72U);
    t15 = *((char **)t14);
    t16 = (t0 + 3368);
    t17 = (t16 + 64U);
    t18 = *((char **)t17);
    t19 = (t0 + 1848U);
    t20 = *((char **)t19);
    xsi_vlog_generic_get_array_select_value(t13, 32, t11, t15, t18, 2, 1, t20, 4, 2);
    t19 = (t0 + 3048);
    xsi_vlogvar_wait_assign_value(t19, t13, 0, 0, 32, 0LL);
    xsi_set_current_line(53, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3368);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t14 = (t0 + 3368);
    t15 = (t14 + 64U);
    t16 = *((char **)t15);
    t17 = (t0 + 2008U);
    t18 = *((char **)t17);
    xsi_vlog_generic_get_array_select_value(t13, 32, t4, t12, t16, 2, 1, t18, 4, 2);
    t17 = (t0 + 3208);
    xsi_vlogvar_wait_assign_value(t17, t13, 0, 0, 32, 0LL);
    goto LAB13;

LAB16:    xsi_set_current_line(61, ng0);

LAB19:    xsi_set_current_line(62, ng0);
    t4 = (t0 + 2328U);
    t5 = *((char **)t4);
    t4 = (t0 + 3368);
    t11 = (t0 + 3368);
    t12 = (t11 + 72U);
    t14 = *((char **)t12);
    t15 = (t0 + 3368);
    t16 = (t15 + 64U);
    t17 = *((char **)t16);
    t18 = (t0 + 2168U);
    t19 = *((char **)t18);
    xsi_vlog_generic_convert_array_indices(t13, t21, t14, t17, 2, 1, t19, 4, 2);
    t18 = (t13 + 4);
    t22 = *((unsigned int *)t18);
    t23 = (!(t22));
    t20 = (t21 + 4);
    t24 = *((unsigned int *)t20);
    t25 = (!(t24));
    t26 = (t23 && t25);
    if (t26 == 1)
        goto LAB20;

LAB21:    xsi_set_current_line(64, ng0);
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

LAB23:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3368);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t14 = (t0 + 3368);
    t15 = (t14 + 64U);
    t16 = *((char **)t15);
    t17 = (t0 + 2168U);
    t18 = *((char **)t17);
    t17 = ((char*)((ng2)));
    memset(t21, 0, 8);
    xsi_vlog_unsigned_add(t21, 32, t18, 4, t17, 32);
    xsi_vlog_generic_get_array_select_value(t13, 32, t4, t12, t16, 2, 1, t21, 32, 2);
    t19 = (t0 + 3368);
    t20 = (t0 + 3368);
    t32 = (t20 + 72U);
    t34 = *((char **)t32);
    t35 = (t0 + 3368);
    t36 = (t35 + 64U);
    t37 = *((char **)t36);
    t38 = (t0 + 2168U);
    t39 = *((char **)t38);
    t38 = ((char*)((ng2)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_add(t40, 32, t39, 4, t38, 32);
    xsi_vlog_generic_convert_array_indices(t31, t33, t34, t37, 2, 1, t40, 32, 2);
    t41 = (t31 + 4);
    t6 = *((unsigned int *)t41);
    t23 = (!(t6));
    t42 = (t33 + 4);
    t7 = *((unsigned int *)t42);
    t25 = (!(t7));
    t26 = (t23 && t25);
    if (t26 == 1)
        goto LAB27;

LAB28:
LAB24:    goto LAB18;

LAB20:    t27 = *((unsigned int *)t13);
    t28 = *((unsigned int *)t21);
    t29 = (t27 - t28);
    t30 = (t29 + 1);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, *((unsigned int *)t21), t30, 0LL);
    goto LAB21;

LAB22:    xsi_set_current_line(65, ng0);
    t4 = (t0 + 2488U);
    t5 = *((char **)t4);
    t4 = (t0 + 3368);
    t11 = (t0 + 3368);
    t12 = (t11 + 72U);
    t14 = *((char **)t12);
    t15 = (t0 + 3368);
    t16 = (t15 + 64U);
    t17 = *((char **)t16);
    t18 = (t0 + 2168U);
    t19 = *((char **)t18);
    t18 = ((char*)((ng2)));
    memset(t31, 0, 8);
    xsi_vlog_unsigned_add(t31, 32, t19, 4, t18, 32);
    xsi_vlog_generic_convert_array_indices(t13, t21, t14, t17, 2, 1, t31, 32, 2);
    t20 = (t13 + 4);
    t22 = *((unsigned int *)t20);
    t23 = (!(t22));
    t32 = (t21 + 4);
    t24 = *((unsigned int *)t32);
    t25 = (!(t24));
    t26 = (t23 && t25);
    if (t26 == 1)
        goto LAB25;

LAB26:    goto LAB24;

LAB25:    t27 = *((unsigned int *)t13);
    t28 = *((unsigned int *)t21);
    t29 = (t27 - t28);
    t30 = (t29 + 1);
    xsi_vlogvar_wait_assign_value(t4, t5, 0, *((unsigned int *)t21), t30, 0LL);
    goto LAB26;

LAB27:    t8 = *((unsigned int *)t31);
    t9 = *((unsigned int *)t33);
    t29 = (t8 - t9);
    t30 = (t29 + 1);
    xsi_vlogvar_wait_assign_value(t19, t13, 0, *((unsigned int *)t33), t30, 0LL);
    goto LAB28;

LAB29:    t8 = *((unsigned int *)t21);
    t9 = *((unsigned int *)t31);
    t29 = (t8 - t9);
    t30 = (t29 + 1);
    xsi_vlogvar_wait_assign_value(t17, t13, 0, *((unsigned int *)t31), t30, 0LL);
    goto LAB30;

}


extern void work_m_00000000002080720771_3998310652_init()
{
	static char *pe[] = {(void *)Initial_30_0,(void *)Cont_36_1,(void *)Always_38_2};
	xsi_register_didat("work_m_00000000002080720771_3998310652", "isim/test_MP_isim_beh.exe.sim/work/m_00000000002080720771_3998310652.didat");
	xsi_register_executes(pe);
}
