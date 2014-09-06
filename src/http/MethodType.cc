/*
 * Auto-Generated File. Changes will be destroyed.
 */
#include "squid.h"
#include "http/MethodType.h"
namespace Http
{

const char *MethodType_str[] = {
	"NONE",
#if NO_SPECIAL_HANDLING
	"LINK",
	"UNLINK",
#endif
	"GET",
	"POST",
	"PUT",
	"HEAD",
	"CONNECT",
	"TRACE",
	"OPTIONS",
	"DELETE",
	"CHECKOUT",
	"CHECKIN",
	"UNCHECKOUT",
	"MKWORKSPACE",
	"VERSION-CONTROL",
	"REPORT",
	"UPDATE",
	"LABEL",
	"MERGE",
	"BASELINE-CONTROL",
	"MKACTIVITY",
#if NO_SPECIAL_HANDLING
	"ORDERPATCH",
	"ACL",
	"MKREDIRECTREF",
	"UPDATEREDIRECTREF",
	"MKCALENDAR",
#endif
	"PROPFIND",
	"PROPPATCH",
	"MKCOL",
	"COPY",
	"MOVE",
	"LOCK",
	"UNLOCK",
	"SEARCH",
#if NO_SPECIAL_HANDLING
	"PATCH",
	"BIND",
	"REBIND",
	"UNBIND",
#endif
	"PURGE",
	"OTHER",
	"ENUM_END"
};
}; // namespace Http
