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
static const char *ng0 = "I:/xilinx_project/copy/new/Assignment_2_stable2_working_properly - Copy - Copy - Copy/AluWrapper.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {31, 0};
static int ng4[] = {63, 0};
static int ng5[] = {32, 0};
static int ng6[] = {2, 0};
static int ng7[] = {3, 0};
static int ng8[] = {1, 0, 0, 0};
static int ng9[] = {4, 0};
static int ng10[] = {5, 0};
static int ng11[] = {6, 0};
static int ng12[] = {7, 0};
static int ng13[] = {0, 0, 0, 0};



static void Always_54_0(char *t0)
{
    char t14[8];
    char t15[8];
    char t16[8];
    char t30[16];
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
    int t13;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    int t21;
    int t22;
    char *t23;
    int t24;
    int t25;
    int t26;
    unsigned int t27;
    int t28;
    int t29;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;

LAB0:    t1 = (t0 + 6528U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(54, ng0);
    t2 = (t0 + 7344);
    *((int *)t2) = 1;
    t3 = (t0 + 6560);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(55, ng0);

LAB5:    xsi_set_current_line(56, ng0);
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

LAB7:    xsi_set_current_line(67, ng0);

LAB10:    xsi_set_current_line(68, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);

LAB11:    t2 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB12;

LAB13:    t2 = ((char*)((ng2)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB14;

LAB15:    t2 = ((char*)((ng6)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB16;

LAB17:    t2 = ((char*)((ng7)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB18;

LAB19:    t2 = ((char*)((ng9)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB20;

LAB21:    t2 = ((char*)((ng10)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB22;

LAB23:    t2 = ((char*)((ng11)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB24;

LAB25:    t2 = ((char*)((ng12)));
    t13 = xsi_vlog_unsigned_case_compare(t3, 3, t2, 32);
    if (t13 == 1)
        goto LAB26;

LAB27:
LAB29:
LAB28:    xsi_set_current_line(186, ng0);

LAB109:    xsi_set_current_line(187, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(188, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(189, ng0);
    t2 = ((char*)((ng13)));
    t4 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 64, 0LL);

LAB30:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(57, ng0);

LAB9:    xsi_set_current_line(58, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 5128);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 32, 0LL);
    xsi_set_current_line(59, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 5288);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(60, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4968);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(61, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(62, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4648);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(63, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(64, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 5448);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB8;

LAB12:    xsi_set_current_line(70, ng0);

LAB31:    xsi_set_current_line(71, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(72, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 1848U);
    t4 = *((char **)t2);
    t2 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng3)));
    t18 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB32;

LAB33:    xsi_set_current_line(74, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng4)));
    t18 = ((char*)((ng5)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB34;

LAB35:    xsi_set_current_line(75, ng0);
    t2 = (t0 + 2968U);
    t4 = *((char **)t2);
    t2 = (t0 + 4328);
    xsi_vlogvar_wait_assign_value(t2, t4, 0, 0, 1, 0LL);
    goto LAB30;

LAB14:    xsi_set_current_line(78, ng0);

LAB36:    xsi_set_current_line(79, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(80, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(81, ng0);
    t2 = (t0 + 2328U);
    t4 = *((char **)t2);
    t2 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng3)));
    t18 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB37;

LAB38:    xsi_set_current_line(82, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng4)));
    t18 = ((char*)((ng5)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB39;

LAB40:    xsi_set_current_line(83, ng0);
    t2 = (t0 + 3128U);
    t4 = *((char **)t2);
    t2 = (t0 + 4328);
    xsi_vlogvar_wait_assign_value(t2, t4, 0, 0, 1, 0LL);
    goto LAB30;

LAB16:    xsi_set_current_line(86, ng0);

LAB41:    xsi_set_current_line(87, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(88, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(89, ng0);
    t2 = (t0 + 2808U);
    t4 = *((char **)t2);
    xsi_vlog_get_part_select_value(t30, 64, t4, 63, 0);
    t2 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t2, t30, 0, 0, 64, 0LL);
    goto LAB30;

LAB18:    xsi_set_current_line(93, ng0);

LAB42:    xsi_set_current_line(94, ng0);
    t4 = (t0 + 2168U);
    t5 = *((char **)t4);
    t4 = (t0 + 1688U);
    t11 = *((char **)t4);
    memset(t14, 0, 8);
    t4 = (t5 + 4);
    if (*((unsigned int *)t4) != 0)
        goto LAB44;

LAB43:    t12 = (t11 + 4);
    if (*((unsigned int *)t12) != 0)
        goto LAB44;

LAB47:    if (*((unsigned int *)t5) < *((unsigned int *)t11))
        goto LAB45;

LAB46:    t18 = (t14 + 4);
    t6 = *((unsigned int *)t18);
    t7 = (~(t6));
    t8 = *((unsigned int *)t14);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB48;

LAB49:    xsi_set_current_line(101, ng0);

LAB52:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 5128);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t11 = ((char*)((ng2)));
    memset(t14, 0, 8);
    xsi_vlog_unsigned_add(t14, 32, t5, 32, t11, 32);
    t12 = (t0 + 5128);
    xsi_vlogvar_wait_assign_value(t12, t14, 0, 0, 32, 0LL);
    xsi_set_current_line(103, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(104, ng0);
    t2 = (t0 + 2168U);
    t4 = *((char **)t2);
    memcpy(t30, t4, 8);
    t2 = (t30 + 8);
    memset(t2, 0, 8);
    t5 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t5, t30, 0, 0, 64, 0LL);

LAB50:    xsi_set_current_line(107, ng0);
    t2 = (t0 + 2168U);
    t4 = *((char **)t2);
    t2 = (t0 + 1688U);
    t5 = *((char **)t2);
    memset(t14, 0, 8);
    xsi_vlog_unsigned_minus(t14, 32, t4, 32, t5, 32);
    t2 = (t0 + 1688U);
    t11 = *((char **)t2);
    memset(t15, 0, 8);
    t2 = (t14 + 4);
    if (*((unsigned int *)t2) != 0)
        goto LAB54;

LAB53:    t12 = (t11 + 4);
    if (*((unsigned int *)t12) != 0)
        goto LAB54;

LAB57:    if (*((unsigned int *)t14) < *((unsigned int *)t11))
        goto LAB55;

LAB56:    t18 = (t15 + 4);
    t6 = *((unsigned int *)t18);
    t7 = (~(t6));
    t8 = *((unsigned int *)t15);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB58;

LAB59:    xsi_set_current_line(112, ng0);

LAB62:    xsi_set_current_line(113, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4648);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);

LAB60:    xsi_set_current_line(116, ng0);
    t2 = (t0 + 2168U);
    t4 = *((char **)t2);
    t2 = (t0 + 1688U);
    t5 = *((char **)t2);
    t2 = (t0 + 1688U);
    t11 = *((char **)t2);
    memset(t14, 0, 8);
    xsi_vlog_unsigned_add(t14, 32, t5, 32, t11, 32);
    memset(t15, 0, 8);
    xsi_vlog_unsigned_minus(t15, 32, t4, 32, t14, 32);
    t2 = (t0 + 1688U);
    t12 = *((char **)t2);
    memset(t16, 0, 8);
    t2 = (t15 + 4);
    if (*((unsigned int *)t2) != 0)
        goto LAB64;

LAB63:    t17 = (t12 + 4);
    if (*((unsigned int *)t17) != 0)
        goto LAB64;

LAB67:    if (*((unsigned int *)t15) < *((unsigned int *)t12))
        goto LAB65;

LAB66:    t19 = (t16 + 4);
    t6 = *((unsigned int *)t19);
    t7 = (~(t6));
    t8 = *((unsigned int *)t16);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB68;

LAB69:    xsi_set_current_line(121, ng0);

LAB72:    xsi_set_current_line(122, ng0);
    t2 = (t0 + 4808);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t11 = (t5 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB73;

LAB74:    xsi_set_current_line(128, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);

LAB75:
LAB70:    goto LAB30;

LAB20:    xsi_set_current_line(157, ng0);

LAB83:    xsi_set_current_line(158, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(159, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(160, ng0);
    t2 = (t0 + 2488U);
    t4 = *((char **)t2);
    t2 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng3)));
    t18 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB84;

LAB85:    xsi_set_current_line(161, ng0);
    t2 = (t0 + 3288U);
    t4 = *((char **)t2);
    t2 = (t0 + 4328);
    xsi_vlogvar_wait_assign_value(t2, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(162, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng4)));
    t18 = ((char*)((ng5)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB86;

LAB87:    goto LAB30;

LAB22:    xsi_set_current_line(165, ng0);

LAB88:    xsi_set_current_line(166, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(167, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(168, ng0);
    t2 = (t0 + 2648U);
    t4 = *((char **)t2);
    t2 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng3)));
    t18 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB89;

LAB90:    xsi_set_current_line(169, ng0);
    t2 = (t0 + 3448U);
    t4 = *((char **)t2);
    t2 = (t0 + 4328);
    xsi_vlogvar_wait_assign_value(t2, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(170, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng4)));
    t18 = ((char*)((ng5)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB91;

LAB92:    goto LAB30;

LAB24:    xsi_set_current_line(174, ng0);

LAB93:    xsi_set_current_line(175, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);
    xsi_set_current_line(176, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(177, ng0);
    t2 = (t0 + 2008U);
    t4 = *((char **)t2);
    t2 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng3)));
    t18 = ((char*)((ng1)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB94;

LAB95:    xsi_set_current_line(178, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4168);
    t5 = (t0 + 4168);
    t11 = (t5 + 72U);
    t12 = *((char **)t11);
    t17 = ((char*)((ng4)));
    t18 = ((char*)((ng5)));
    xsi_vlog_convert_partindices(t14, t15, t16, ((int*)(t12)), 2, t17, 32, 1, t18, 32, 1);
    t19 = (t14 + 4);
    t6 = *((unsigned int *)t19);
    t13 = (!(t6));
    t20 = (t15 + 4);
    t7 = *((unsigned int *)t20);
    t21 = (!(t7));
    t22 = (t13 && t21);
    t23 = (t16 + 4);
    t8 = *((unsigned int *)t23);
    t24 = (!(t8));
    t25 = (t22 && t24);
    if (t25 == 1)
        goto LAB96;

LAB97:    goto LAB30;

LAB26:    xsi_set_current_line(181, ng0);

LAB98:    xsi_set_current_line(182, ng0);
    t4 = (t0 + 1528U);
    t5 = *((char **)t4);
    memset(t14, 0, 8);
    t4 = (t5 + 4);
    t6 = 1;
    t7 = *((unsigned int *)t5);
    t8 = *((unsigned int *)t5);
    t8 = (t8 & 1);
    if (*((unsigned int *)t4) != 0)
        goto LAB99;

LAB100:    t9 = 0;

LAB102:    t10 = (t9 <= 31);
    if (t10 == 1)
        goto LAB103;

LAB104:    t31 = (!(t8));
    *((unsigned int *)t14) = t31;

LAB101:    t12 = (t0 + 5448);
    xsi_vlogvar_wait_assign_value(t12, t14, 0, 0, 1, 0LL);
    xsi_set_current_line(183, ng0);
    t2 = (t0 + 4168);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t11 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t11, t5, 0, 0, 64, 0LL);
    goto LAB30;

LAB32:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t2, t4, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB33;

LAB34:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t4, t2, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB35;

LAB37:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t2, t4, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB38;

LAB39:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t4, t2, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB40;

LAB44:    t17 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t17) = 1;
    goto LAB46;

LAB45:    *((unsigned int *)t14) = 1;
    goto LAB46;

LAB48:    xsi_set_current_line(95, ng0);

LAB51:    xsi_set_current_line(96, ng0);
    t19 = ((char*)((ng2)));
    t20 = (t0 + 4488);
    xsi_vlogvar_wait_assign_value(t20, t19, 0, 0, 1, 0LL);
    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 5128);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(98, ng0);
    t2 = (t0 + 5128);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t11 = ((char*)((ng8)));
    xsi_vlog_unsigned_add(t30, 64, t5, 32, t11, 32);
    t12 = (t0 + 4168);
    xsi_vlogvar_wait_assign_value(t12, t30, 0, 0, 64, 0LL);
    goto LAB50;

LAB54:    t17 = (t15 + 4);
    *((unsigned int *)t15) = 1;
    *((unsigned int *)t17) = 1;
    goto LAB56;

LAB55:    *((unsigned int *)t15) = 1;
    goto LAB56;

LAB58:    xsi_set_current_line(108, ng0);

LAB61:    xsi_set_current_line(109, ng0);
    t19 = ((char*)((ng2)));
    t20 = (t0 + 4648);
    xsi_vlogvar_wait_assign_value(t20, t19, 0, 0, 1, 0LL);
    goto LAB60;

LAB64:    t18 = (t16 + 4);
    *((unsigned int *)t16) = 1;
    *((unsigned int *)t18) = 1;
    goto LAB66;

LAB65:    *((unsigned int *)t16) = 1;
    goto LAB66;

LAB68:    xsi_set_current_line(117, ng0);

LAB71:    xsi_set_current_line(118, ng0);
    t20 = ((char*)((ng2)));
    t23 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t23, t20, 0, 0, 1, 0LL);
    goto LAB70;

LAB73:    xsi_set_current_line(123, ng0);
    t12 = (t0 + 4488);
    t17 = (t12 + 56U);
    t18 = *((char **)t17);
    memset(t14, 0, 8);
    t19 = (t18 + 4);
    t27 = *((unsigned int *)t19);
    t31 = (~(t27));
    t32 = *((unsigned int *)t18);
    t33 = (t32 & t31);
    t34 = (t33 & 1U);
    if (t34 != 0)
        goto LAB79;

LAB77:    if (*((unsigned int *)t19) == 0)
        goto LAB76;

LAB78:    t20 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t20) = 1;

LAB79:    t23 = (t14 + 4);
    t35 = *((unsigned int *)t23);
    t36 = (~(t35));
    t37 = *((unsigned int *)t14);
    t38 = (t37 & t36);
    t39 = (t38 != 0);
    if (t39 > 0)
        goto LAB80;

LAB81:    xsi_set_current_line(126, ng0);
    t2 = ((char*)((ng1)));
    t4 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t4, t2, 0, 0, 1, 0LL);

LAB82:    goto LAB75;

LAB76:    *((unsigned int *)t14) = 1;
    goto LAB79;

LAB80:    xsi_set_current_line(124, ng0);
    t40 = ((char*)((ng2)));
    t41 = (t0 + 4808);
    xsi_vlogvar_wait_assign_value(t41, t40, 0, 0, 1, 0LL);
    goto LAB82;

LAB84:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t2, t4, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB85;

LAB86:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t4, t2, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB87;

LAB89:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t2, t4, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB90;

LAB91:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t4, t2, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB92;

LAB94:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t2, t4, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB95;

LAB96:    t9 = *((unsigned int *)t16);
    t26 = (t9 + 0);
    t10 = *((unsigned int *)t14);
    t27 = *((unsigned int *)t15);
    t28 = (t10 - t27);
    t29 = (t28 + 1);
    xsi_vlogvar_wait_assign_value(t4, t2, t26, *((unsigned int *)t15), t29, 0LL);
    goto LAB97;

LAB99:    t11 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB101;

LAB103:    if (t6 == 1)
        goto LAB106;

LAB107:    t27 = (t7 & 1);
    t8 = (t8 ^ t27);

LAB108:    t7 = (t7 >> 1);

LAB105:    t9 = (t9 + 1);
    goto LAB102;

LAB106:    t6 = 0;
    goto LAB108;

}

static void implSig1_execute(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 6776U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = ((char*)((ng2)));
    t3 = (t0 + 7424);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t2, 8);
    xsi_driver_vfirst_trans(t3, 0, 31);

LAB1:    return;
}

static void implSig2_execute(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 7024U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = ((char*)((ng2)));
    t3 = (t0 + 7488);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t2, 8);
    xsi_driver_vfirst_trans(t3, 0, 31);

LAB1:    return;
}


extern void work_m_00000000000716052509_2771940131_init()
{
	static char *pe[] = {(void *)Always_54_0,(void *)implSig1_execute,(void *)implSig2_execute};
	xsi_register_didat("work_m_00000000000716052509_2771940131", "isim/test_MP_isim_beh.exe.sim/work/m_00000000000716052509_2771940131.didat");
	xsi_register_executes(pe);
}
