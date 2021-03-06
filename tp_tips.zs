/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2019
 *
 * This file is a part of Tips.pk3.
 *
 * Tips.pk3 is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Tips.pk3 is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Tips.pk3.  If not, see <https://www.gnu.org/licenses/>.
 */

/**
 * This class draws a note at the bottom of the screen.
 *
 * It respects tp_show_notes CVar.
 */
class tp_ListMenuNote : ListMenuItem
{

// public: /////////////////////////////////////////////////////////////////////

  tp_ListMenuNote init()
  {
    add("\"The situation is so much better for programmers today - a cheap used PC, "
        "a linux CD, and an internet account, and you have all the tools necessary "
        "to work your way to any level of programming skill you want to shoot for.\"\n"
        " - John Carmack");

    add("\"Explicit is better than implicit.\"\n"
        " - Tim Peters, The Zen of Python");

    add("doomwiki.org is the Doom Wiki.");

    add("\"For every complex problem there is an answer that is clear, simple, and wrong.\"\n"
        " - H. L. Mencken");

    add("#include <stdio.h>\n"
        "int main() { printf(\"Hello, World!\"); return 0; }");

    add("#include <iostream>\n"
        "int main() { std::cout << \"Hello, World!\" << std::endl; return 0; }");

    add("#!/bin/sh\n"
        "echo \"Hello, World!\"");

    add("#!python3\n"
        "if __name__ == \"__main__\":\n"
        "    print(\"Hello, World!\")");

    add("\"Never send a human to do a machine’s job.\"\n"
        " - Agent Smith, The Matrix");

    Super.Init();
    return self;
  }

  override
  bool, String GetString(int i)
  {
    // unused: i
    return true, "ListMenuNote";
  }

// public: // ListMenuItem /////////////////////////////////////////////////////

  override
  void OnMenuCreated()
  {
    _iString = random(0, _strings.size() - 1);
  }

  override
  void Drawer(bool selected)
  {
    // unused: selected

    if (!tp_show_notes)
    {
      return;
    }

    int    width  = (Screen.GetWidth() / CleanXFac_1) * 3 / 4;
    let    lines  = NewSmallFont.BreakLines(_strings[_iString], width);
    int    nLines = lines.Count();
    double height = NewSmallFont.GetHeight();
    double y      = Screen.GetHeight() - MARGIN - height * nLines * CleanYFac_1;

    for (int i = 0; i < nLines; ++i)
    {
      double x = Screen.GetWidth() - MARGIN - lines.StringWidth(i) * CleanXFac_1;
      Screen.DrawText( NewSmallFont, Font.CR_WHITE, x, y, lines.StringAt(i)
                     , DTA_CleanNoMove_1, true
                     );
      y += height * CleanYFac_1;
    }
  }

// private: ////////////////////////////////////////////////////////////////////

  private ui
  void add(String s)
  {
    _strings.push(s);
  }

// private: ////////////////////////////////////////////////////////////////////

  const MARGIN = 10;

// private: ////////////////////////////////////////////////////////////////////

  /// Must contain at least 1 string.
  private ui Array<String> _strings;
  private ui uint          _iString;

} // class tp_ListMenuNote

class OptionMenuItemtp_MenuInjector : OptionMenuItem
{

// public: /////////////////////////////////////////////////////////////////////

  void Init()
  {
    injectNote("MainMenu");
    injectNote("MainMenuTextOnly");
  }

// private /////////////////////////////////////////////////////////////////////

  /**
   * This function assumes that menu with name @a menuName exists and is a ListMenu.
   */
  void injectNote(String menuName)
  {
    let descriptor = ListMenuDescriptor(MenuDescriptor.GetDescriptor(menuName));

    bool   hasString;
    String string;
    [hasString, string] = descriptor.mItems[descriptor.mItems.size() - 1].GetString(0);

    if (hasString && string == "ListMenuNote")
    {
      return;
    }

    descriptor.mItems.Push(new("tp_ListMenuNote").init());
  }

} // class OptionMenuItemtp_MenuInjector
