class WillDocument < Prawn::Document

  def initialize(will, testator, delegates, bequests)
    super(top_margin: 50, font: 'Times-Roman')

    @will = will
    @testator = testator
    @delegates = delegates
    @bequests = bequests
    @addr = "3927 Vincent Drive NW, Calgary, Alberta, Canada"
    @executors = @delegates.select {|delegate| delegate.executor == true}

    font 'Times-Roman'



    title

    move_down 12
    opening

    move_down 12
    expenses_and_taxes

    move_down 12
    personal_representatives

    move_down 12
    disposition_of_property

    move_down 12
    omission

    move_down 12
    bond

    move_down 12
    powers_of_executor

    move_down 12
    contesting_beneficiary

    move_down 12
    guardian

    move_down 12
    gender

    move_down 12
    assignment

    move_down 12
    governing_law

    move_down 12
    binding_arrangment
    
  end

  def title
    text "Last Will and Testament", align: :center, size: 18
    text @testator.full_name, align: :center, size: 14
  end

  def opening
    text "I, #{@testator.full_name}, resident in the City of #{"@testator.city"}, Country of #{"@testator.country"}, being of sound mind, not acting under duress or undue influence, and fully understanding the nature and extent of all my property and of this disposition thereof, do hereby make, publish, and declare this document to be my Last Will and Testament, and hereby revoke any and all other wills and codiclies heretofore made by me either jointy or severally."
  end
  
  def expenses_and_taxes
    text "I. EXPENSES & TAXES"
    text "I direct that all my debts, and expenses of my last illness, funeral, and burial, be paid as soon after my death as may be reasonably convenient, and I hereby authorize my Personal Representative, hereafter appointed, to settle and discharge, in his or her absolute discresion, any claims made against my estate.\n\nI further direct that my Personal Representative shall pay out my estate any and all estate and inheritance taxes payable by reason of my death in respect of all items included in comptutation of such taxes, wether passing under this Will of otherwise. Said taxes shall be paid by my Personal Representative as if such taxes were my debts without recovery of any part of such taxt payments from anyone who receives any item included in such comptutation."
  end

  def personal_representatives
    text "II. PERSONAL REPRESENTATIVE"
    text "I nominate and appoint ________________________, of
    ___________________________, County of ________________________, State of
    ______________________________ as Personal Representative of my estate and I
    request that (he/she) be appointed temporary Personal Representative if (he/she)
    applies. If my Personal Representative fails or ceases to so serve, then I nominate
    _____________________________of __________________________, County of
    ____________________________, State of ______________________ to serve. "
  end

  def disposition_of_property
    text "III. DISPOSITION OF PROPERTY"
    text "I devise and bequeath my property, both real and personal and wherever situated, as follows:"
    move_down 4
    @delegates.each_with_index do |delegate, i|
      unless delegate.bequests.empty?
        text "Beneficiary #{i+1}:"
        text "#{delegate.full_name}, currently of #{"Canada, Calgary"}, as my #{delegate.relation.downcase}, with the following property"
        delegate.bequests.each_with_index do |bequest, j|
          if bequest.percentage != 100
            text "#{j+1}. #{bequest.percentage}% of the #{bequest.asset.title}, at the address #{@addr}.", indent_paragraphs: 30
          else 
            text "#{j+1}. #{bequest.asset.title}, at the address #{@addr}", indent_paragraphs: 30
          end
        end
        move_down 12
      end
    end
    text "If any of my beneficiaries have pre-deceased me, then any property that they would have received if they had not pre-deceased me shall be distributed in equal shares to the remaining beneficiaries. If any of my property cannot be readily sold and distributed, then it may be donated to any charitable organization or organizations of my Personal Representative’s choice. If any property cannot be readily sold or donated, my Personal Representative may, without liability, dispose of such property as my Personal Representative may deem appropriate. I authorize my Personal Representative to pay as an administration expense of my estate the expense of selling, advertising for sale, packing, shipping, insuring and delivering such property."
  end

  def omission
    text "IV. OMISSION"
    text "Except to the extent that I have included them in this Will, I have intentionally, and not
    as a result of any mistake or inadvertence, omitted in this Will to provide for any family
    members and/or issue of mine, if any, however defined by law, presently living or
    hereafter born or adopted."
  end

  def bond
    text "V. BOND"
    text "No bond shall be required of any fiduciary serving hereunder, whether or not specifically
    named in this Will, or if a bond is required by law, then no surety will be required on
    such bond."
  end

  def powers_of_executor
    text "VI. DISCRETIONARY POWERS OF PERSONAL REPRESENTATIVE"
    text "My Personal Representative, shall have and may exercise the following discretionary
    powers in addition to any common law or statutory powers without the necessity of court
    license or approval:
    A. To retain for whatever period my Personal Representative deems advisable any
    property, including property owned by me at my death, and to invest and reinvest in any
    property, both real and personal, regardless of whether any particular investment would
    be proper for a Personal Representative and regardless of the extent of diversification
    of the assets held hereunder.
    B. To sell and to grant options to purchase all or any part of my estate, both real
    and personal, at any time, at public or private sale, for consideration, whether or not the
    highest possible consideration, and upon terms, including credit, as my Personal
    Representative deems advisable, and to execute, acknowledge, and deliver deeds or
    other instruments in connection therewith.
    C. To lease any real estate for terms and conditions as my Personal Representative
    deems advisable, including the granting of options to renew, options to extend the term
    or terms, and options to purchase.
    D. To pay, compromise, settle or otherwise adjust any claims, including taxes,
    asserted in favor of or against me, my estate or my Personal Representative.
    E. To make any separation into shares in whole or in part in kind and at values
    determined by my Personal Representative, with or without regard to tax basis, and to
    allocate different kinds and disproportionate amounts of property and undivided
    interests in property among the shares.
    F. To make such elections under the tax laws as my Personal Representative shall
    deem appropriate, including elections with respect to qualified terminable interest
    property, exemptions and the use of deductions as income tax or estate tax deductions,
    and to determine whether to make any adjustments between income and principal on
    account of any election so made.
    G. To make any elections permitted under any pension, profit sharing, employee
    stock ownership or other benefit plan.
    H. To employ others in connection with the administration of my estate, including
    legal counsel, investment advisors, brokers, accountants and agents and to pay
    reasonable compensation in addition to my Personal Representative’s compensation.
    I. To vote any shares of stock or other securities in person or by proxy; to assert or
    waive any stockholder’s rights or privilege to subscribe for or otherwise acquire
    additional stock; to deposit securities in any voting trust or with any committee.
    J. To borrow and to pledge or mortgage any property as collateral, and to make
    secured or unsecured loans. My Personal Representative is specifically authorized to
    make loans without interest to any beneficiary hereunder. No individual or entity loaning
    property to my Personal Representative or trustee shall be held to see to the application
    of such property.
    K. My Personal Representative shall also in his or her absolute discretion determine
    the allocation of any GST exemption available to me at my death to property passing
    under this Will or otherwise. The determination of my Personal Representative with
    respect to any elections or allocation, if made or taken in good faith, shall be binding
    upon all affected."
  end

  def contesting_beneficiary
    text "VII. CONTESTING BENEFICIARY"
    text "If any beneficiary under this Will, or any trust herein mentioned, contests or attacks this
    Will or any of its provisions, any share or interest in my estate given to that contesting 
    beneficiary under this Will is revoked and shall be disposed of in the same manner
    provided herein as if that contesting beneficiary had predeceased me."
  end

  def guardian
    text "VIII. GUARDIAN AD LITEM NOT REQUIRED"
    text "I direct that the representation by a guardian ad litem of the interests of persons unborn,
    unascertained or legally incompetent to act in proceedings for the allowance of
    accounts hereunder be dispensed with to the extent permitted by law."
  end

  def gender
    text "IX. GENDER"
    text "Whenever the context permits, the term “Personal Representative” shall include
    “Executor” and “Administrator,” the use of a particular gender shall include any other
    gender, and references to the singular or the plural shall be interchangeable. All
    references to the Internal Revenue Code shall mean the Internal Revenue Code of
    1986 or any successor Code. All references to estate taxes shall include inheritance
    and other death taxes. "
  end

  def assignment
    text "X. ASSIGNMENT"
    text "The interest of any beneficiary in this Will, shall not be alienable, assignable, attachable,
    transferable nor paid by way of anticipation, nor in compliance with any order,
    assignment or covenant and shall not be applied to, or held liable for, any of their debts
    or obligations either in law or equity and shall not in any event pass to his, her, or their
    assignee under any instrument or under any insolvency or bankruptcy law, and shall not
    be subject to the interference or control of creditors, spouses or others."
  end

  def governing_law
    text "XI. GOVERNING LAW"
    text "This document shall be governed by the laws of the State of _____________________."

  end

  def binding_arrangment
    text "XII. BINDING ARRANGEMENT"
    text "Any decision by my Personal Representative with respect to any discretionary power
    hereunder shall be final and binding on all persons interested. Unless due to my
    Executor’s own willful default or gross negligence, no Executor shall be liable for said
    Executor’s acts or omissions or those of any co-Executor or prior Executor.
    I, the undersigned ________________________, do hereby declare that I sign and
    execute this instrument as my last Will, that I sign it willingly in the presence of each of
    the undersigned witnesses, and that I execute it as my free and voluntary act for the
    purposes herein expressed, on this ____ day of ________________, 20____.
    ________________________________ ___________________________________
    Testator Signature Testator (Printed Name)"

    text "The foregoing instrument, was on this ____ day of ________________, 20____,
    subscribed on each page and at the end thereof by ________________________, the 
    above-named Testator, and by (him/her) signed, sealed, published and declared to be
    (his/her) LAST WILL AND TESTAMENT, in the presence of us and each of us, who
    thereupon, at (his/her) request, in (his/her) presence, and in the presence of each other,
    have hereunto subscribed our names as attesting witnesses thereto.
    ________________________________ ___________________________________
    Witness Signature Address
    ________________________________ ___________________________________
    Witness Signature Address"
  end

  def testamentary_affidavit
    text "TESTAMENTARY AFFIDAVIT"
    text "STATE OF ____________________
    COUNTY OF __________________, SS.
    Before me, the undersigned authority, on this day personally appeared
    ___________, testator, ____________________, witness and ___________________,
    witness, known to me to be the testator and the witnesses, respectively, whose names
    are signed to the attached or foregoing instrument, and, all of these persons being by
    me duly sworn, the testator declared to me and to the witnesses in my presence that the
    instrument is the testator’s last will and that the testator has willingly signed or directed
    another to sign for him/her, and that the testator executed it as the testator’s free and
    voluntary act for the purposes therein expressed; and each of the witnesses stated to
    me, in the presence of the testator, that they signed the will as witnesses and that to the
    best of their knowledge the testator was eighteen (18) years of age or over, of sound
    mind and under no constraint or undue influence.
    ______________________________ ______________________________
    Testator Signature Witness Signature
     ______________________________
     Witness Signature
    Subscribed and sworn to before me by the said testator and the said witnesses, this
    ____ day of ________________, 20____.
    ________________________________
    Notary Public
    My Commission expires:"
  end

end