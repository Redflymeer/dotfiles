#include <iostream>
#include <cstdlib>
#include <string>
#include <cctype>

int main () {
  // Interface 
  std::string interface;
  std::string mkwith;

  
  std::cout << "!!! WARNING !!! Run as root\n \n \n";
  std::cout << "What interface do you want turn off/turn on? (basicly eth1/eth0/wlan0) ";
  std::getline(std::cin, interface);
  std::cout << "What you make with " << interface << " (down or up) ";
  std::getline(std::cin, mkwith);


  std::string cmd = "ip link set " + interface + " " + mkwith;
  int rc = std::system(cmd.c_str());
  return rc == -1 ? 1 : 0;
}
